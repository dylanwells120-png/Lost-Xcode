import SwiftUI
import RealityKit
import LostCore

/// Gray-box test scene: ground, a capsule standing in for Rose, a flashlight and a dim sky.
/// Swap `makeRose()` for the rigged USDZ model once it is ready.
struct GameView: View {
    @StateObject private var input = InputController()
    @State private var rose = Entity()
    @State private var lastUpdate = Date()
    private let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .topLeading) {
            RealityView { content in
                content.add(makeGround())
                rose = makeRose()
                content.add(rose)
                let light = Entity()
                light.components.set(SpotLightComponent(color: .white, intensity: 20_000,
                                                        innerAngleInDegrees: 20, outerAngleInDegrees: 50,
                                                        attenuationRadius: 20))
                light.position = [0, 1.0, 0]
                rose.addChild(light)
            }
            Text(hud).font(.system(.body, design: .monospaced)).padding(12)
                .foregroundStyle(.white).shadow(radius: 2)
        }
        .background(Color.black)
        .onReceive(timer) { now in
            let dt = Float(now.timeIntervalSince(lastUpdate))
            lastUpdate = now
            step(dt)
        }
    }

    private var hud: String {
        "mode: \(input.mode)  noise radius: \(Int(input.mode.noiseRadius)) m"
    }

    private func step(_ dt: Float) {
        let mode = input.mode
        let v = input.move
        guard mode != .idle else { return }
        // Stick y is forward; world forward is -z.
        let direction = SIMD3<Float>(v.x, 0, -v.y)
        rose.position += direction * mode.speed * dt
        rose.look(at: rose.position + direction, from: rose.position, relativeTo: nil)
    }

    private func makeGround() -> ModelEntity {
        ModelEntity(mesh: .generatePlane(width: 100, depth: 100),
                    materials: [SimpleMaterial(color: .init(white: 0.15, alpha: 1), isMetallic: false)])
    }

    private func makeRose() -> Entity {
        let body = ModelEntity(mesh: .generateBox(width: 0.3, height: 1.2, depth: 0.3, cornerRadius: 0.1),
                               materials: [SimpleMaterial(color: .systemRed, isMetallic: false)])
        body.position = [0, 0.6, 0]
        let root = Entity()
        root.addChild(body)
        return root
    }
}
