import Foundation
import GameController
import LostCore

/// Reads a game controller (or WASD + Shift/Ctrl as a fallback) into a simple input snapshot.
@MainActor
final class InputController: ObservableObject {
    @Published private(set) var move = SIMD2<Float>(0, 0)
    @Published private(set) var running = false
    @Published private(set) var crouching = false
    @Published private(set) var flashlightToggled = false

    init() {
        NotificationCenter.default.addObserver(
            forName: .GCControllerDidConnect, object: nil, queue: .main
        ) { [weak self] _ in
            Task { @MainActor in self?.bindFirstController() }
        }
        bindFirstController()
    }

    private func bindFirstController() {
        guard let pad = GCController.controllers().first?.extendedGamepad else { return }
        pad.leftThumbstick.valueChangedHandler = { [weak self] _, x, y in
            Task { @MainActor in self?.move = SIMD2(x, y) }
        }
        // Right trigger = run, B = crouch (hold), X = flashlight.
        pad.rightTrigger.valueChangedHandler = { [weak self] _, value, _ in
            Task { @MainActor in self?.running = value > 0.5 }
        }
        pad.buttonB.valueChangedHandler = { [weak self] _, _, pressed in
            Task { @MainActor in self?.crouching = pressed }
        }
        pad.buttonX.valueChangedHandler = { [weak self] _, _, pressed in
            if pressed { Task { @MainActor in self?.flashlightToggled.toggle() } }
        }
    }

    var mode: MovementMode {
        let magnitude = (move.x * move.x + move.y * move.y).squareRoot()
        return .from(stickMagnitude: magnitude, running: running, crouching: crouching)
    }
}
