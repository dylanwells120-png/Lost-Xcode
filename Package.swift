// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Lost",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "Lost", targets: ["Lost"]),
        .library(name: "LostCore", targets: ["LostCore"]),
    ],
    targets: [
        // Pure Swift game logic (no Apple frameworks) so it is easy to unit test.
        .target(name: "LostCore"),
        // macOS app: SwiftUI + RealityKit + GameController.
        .executableTarget(name: "Lost", dependencies: ["LostCore"]),
        .testTarget(name: "LostCoreTests", dependencies: ["LostCore"]),
    ]
)
