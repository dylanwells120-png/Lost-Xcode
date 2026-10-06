import AppKit
import Foundation
import GameController
import LostCore

/// Reads a game controller and the keyboard into one input snapshot.
///
/// Controller: left stick moves, right trigger runs, B (hold) crouches, X toggles flashlight.
/// Keyboard: WASD / arrows move, Shift runs, Ctrl or C crouches, F toggles flashlight.
@MainActor
final class InputController: ObservableObject {
    @Published private(set) var move = SIMD2<Float>(0, 0)
    @Published private(set) var running = false
    @Published private(set) var crouching = false
    @Published private(set) var flashlightToggled = false

    private var padMove = SIMD2<Float>(0, 0)
    private var padRunning = false
    private var padCrouching = false
    private var keysDown = Set<UInt16>()
    private var shiftDown = false
    private var controlDown = false
    private var keyMonitor: Any?

    // Key codes (US layout, hardware based).
    private enum Key {
        static let a: UInt16 = 0, s: UInt16 = 1, d: UInt16 = 2, w: UInt16 = 13
        static let c: UInt16 = 8, f: UInt16 = 3
        static let left: UInt16 = 123, right: UInt16 = 124, down: UInt16 = 125, up: UInt16 = 126
    }
    private static let handledKeys: Set<UInt16> = [
        Key.a, Key.s, Key.d, Key.w, Key.c, Key.f, Key.left, Key.right, Key.down, Key.up,
    ]

    init() {
        NotificationCenter.default.addObserver(
            forName: .GCControllerDidConnect, object: nil, queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in self.bindFirstController() }
        }
        bindFirstController()
        startKeyboard()
    }

    deinit {
        if let keyMonitor { NSEvent.removeMonitor(keyMonitor) }
    }

    // MARK: Keyboard

    private func startKeyboard() {
        keyMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp, .flagsChanged]) { [weak self] event in
            guard let self else { return event }
            return MainActor.assumeIsolated { self.handle(event) }
        }
    }

    private func handle(_ event: NSEvent) -> NSEvent? {
        switch event.type {
        case .flagsChanged:
            shiftDown = event.modifierFlags.contains(.shift)
            controlDown = event.modifierFlags.contains(.control)
            refresh()
            return event
        case .keyDown:
            guard Self.handledKeys.contains(event.keyCode) else { return event }
            if !event.isARepeat {
                keysDown.insert(event.keyCode)
                if event.keyCode == Key.f { flashlightToggled.toggle() }
            }
            refresh()
            return nil  // swallow so macOS doesn't beep
        case .keyUp:
            guard Self.handledKeys.contains(event.keyCode) else { return event }
            keysDown.remove(event.keyCode)
            refresh()
            return nil
        default:
            return event
        }
    }

    private var keyboardMove: SIMD2<Float> {
        var x: Float = 0, y: Float = 0
        if keysDown.contains(Key.a) || keysDown.contains(Key.left) { x -= 1 }
        if keysDown.contains(Key.d) || keysDown.contains(Key.right) { x += 1 }
        if keysDown.contains(Key.w) || keysDown.contains(Key.up) { y += 1 }
        if keysDown.contains(Key.s) || keysDown.contains(Key.down) { y -= 1 }
        let length = (x * x + y * y).squareRoot()
        return length > 1 ? SIMD2(x / length, y / length) : SIMD2(x, y)
    }

    /// Combines controller and keyboard state into the published values.
    private func refresh() {
        let keys = keyboardMove
        let padLength = (padMove.x * padMove.x + padMove.y * padMove.y).squareRoot()
        move = padLength > 0.1 ? padMove : keys
        running = padRunning || shiftDown
        crouching = padCrouching || controlDown || keysDown.contains(Key.c)
    }

    // MARK: Controller

    private func bindFirstController() {
        guard let pad = GCController.controllers().first?.extendedGamepad else { return }
        pad.leftThumbstick.valueChangedHandler = { [weak self] _, x, y in
            guard let self else { return }
            Task { @MainActor in
                self.padMove = SIMD2(x, y)
                self.refresh()
            }
        }
        pad.rightTrigger.valueChangedHandler = { [weak self] _, value, _ in
            guard let self else { return }
            Task { @MainActor in
                self.padRunning = value > 0.5
                self.refresh()
            }
        }
        pad.buttonB.valueChangedHandler = { [weak self] _, _, pressed in
            guard let self else { return }
            Task { @MainActor in
                self.padCrouching = pressed
                self.refresh()
            }
        }
        pad.buttonX.valueChangedHandler = { [weak self] _, _, pressed in
            guard pressed, let self else { return }
            Task { @MainActor in self.flashlightToggled.toggle() }
        }
    }

    var mode: MovementMode {
        let magnitude = (move.x * move.x + move.y * move.y).squareRoot()
        return .from(stickMagnitude: magnitude, running: running, crouching: crouching)
    }
}
