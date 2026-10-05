e

## Building

Requires a Mac with Xcode 15+ (macOS 14+, Apple silicon).

1. `git clone` the repo, then in Xcode choose **File > Open** and select the `Lost-Xcode` folder (it opens `Package.swift`).
2. Pick the **Lost** scheme with **My Mac** as the destination and press Run.
3. Connect a game controller: left stick moves, right trigger runs, B (hold) crouches.
4. Run tests with **Cmd+U** (or `swift test`).

Layout: `Sources/LostCore` is pure-Swift game logic (movement, noise, Hollow AI) with unit tests; `Sources/Lost` is the macOS app (SwiftUI + RealityKit + GameController).
