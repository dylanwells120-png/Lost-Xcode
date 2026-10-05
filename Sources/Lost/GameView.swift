import SwiftUI
import RealityKit
import AppKit
import LostCore

/// Owns the RealityKit scene: ground, a capsule standing in for Rose, a flashlight and a follow camera.
/// Swap `makeRose()` for the rigged USDZ model once it is ready.
@MainActor
final class GameWorld {
    let view = ARView(frame: .zero)
    private let rose = Entity()
    private let camera = PerspectiveCamera()
    private let cameraOffset = SIMD3<Float>(0, 5, 6)

    init() {
        view.environment.background = .color(.black)
        let anchor = AnchorEntity(world: .zero)
        anchor.addChild(makeGround())
        rose.addChild(makeRoseBody())
        rose.addChild(makeFlashlight())
        anchor.addChild(rose)
        anchor.addChild(camera)
        view.scene.addAnchor(anchor)
        updateCamera()
    }

    func step(input: InputController, deltaTime dt: Float) {
        let mode = input.mode
        guard mode != .idle else { return }
        let v = input.move
        // Stick y is forward; world forward is -z.
        let direction = SIMD3<Float>(v.x, 0, -v.y)
        rose.position += direction * mode.speed * dt
        rose.look(at: rose.position + direction, from: rose.position, relativeTo: nil)
        updateCamera()
    }

    private func updateCamera() {
        camera.look(at: rose.position + [0, 1, 0], from: rose.position + cameraOffset, relativeTo: nil)
    }

    private func makeGround() -> ModelEntity {
        ModelEntity(mesh: .generatePlane(width: 100, depth: 100),
                    materials: [SimpleMaterial(color: NSColor(white: 0.15, alpha: 1), isMetallic: false)])
    }

    private func makeRoseBody() -> ModelEntity {
        let body = ModelEntity(mesh: .generateBox(width: 0.3, height: 1.2, depth: 0.3, cornerRadius: 0.1),
                               materials: [SimpleMaterial(color: .systemRed, isMetallic: false)])
        body.position = [0, 0.6, 0]
        return body
    }

    private func makeFlashlight() -> Entity {
        let light = Entity()
        light.components.set(SpotLightComponent(color: .white, intensity: 20_000,
                                                innerAngleInDegrees: 20, outerAngleInDegrees: 50,
                                                attenuationRadius: 20))
        light.position = [0, 1.0, 0]
        return light
    }
}

struct SceneView: NSViewRepresentable {
    let world: GameWorld
    func makeNSView(context: Context) -> ARView { world.view }
    func updateNSView(_ nsView: ARView, context: Context) {}
}

struct GameView: View {
    @StateObject private var input = InputController()
    @State private var world = GameWorld()
    @State private var lastUpdate = Date()
    private let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .topLeading) {
            SceneView(world: world)
            Text(hud).font(.system(.body, design: .monospaced)).padding(12)
                .foregroundStyle(.white).shadow(radius: 2)
        }
        .background(Color.black)
        .onReceive(timer) { now in
            let dt = Float(now.timeIntervalSince(lastUpdate))
            lastUpdate = now
            world.step(input: input, deltaTime: dt)
        }
    }

    private var hud: String {
        "mode: \(input.mode)  noise radius: \(Int(input.mode.noiseRadius)) m"
    }
}
