e

## Building

Requires a Mac with Xcode 15+ (macOS 14+, Apple silicon).

1. Get the project: `git clone https://github.com/dylanwells120-png/Lost-Xcode.git`, then `cd Lost-Xcode && git checkout claude/xcode-project`. (Or use GitHub's **Code > Download ZIP** on the `claude/xcode-project` branch.)
2. In Xcode choose **File > Open** and select the `Lost-Xcode` folder (it opens `Package.swift`).
3. Pick the **Lost** scheme with **My Mac** as the destination and press Run (Cmd+R).
4. Run tests with Cmd+U (or `swift test`).

## Controls

| Action | Keyboard | Controller |
|---|---|---|
| Move | WASD / arrow keys | Left stick |
| Run (loud) | Hold Shift | Right trigger |
| Crouch (quiet) | Hold Ctrl or C | Hold B |
| Flashlight toggle (not wired up yet) | F | X |

The HUD shows Rose's current movement mode and noise radius.

Layout: `Sources/LostCore` is pure-Swift game logic (movement, noise, Hollow AI) with unit tests; `Sources/Lost` is the macOS app (SwiftUI + RealityKit + GameController).
