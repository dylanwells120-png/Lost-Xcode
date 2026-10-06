# Lost — Handoff

Last updated: 2026-10-06. Read this first, then `GAME_DESIGN.md` (story, mechanics, architecture, roadmap) and `README.md` (build and controls).

## What this is
*Lost*: an open-world post-apocalyptic 3D drama/horror game. Rose (8) is separated from her family and searches for them. Built natively for Mac in Xcode.

## Decisions already made
- Fully Apple-native (Swift, RealityKit, GameplayKit, Metal, AVAudioEngine). No Unity/Unreal.
- Mac and game controller first. iPhone/iPad touch comes later.
- One-time purchase plus in-app purchases. In-app purchases stay cosmetic or convenience; never gate the story.
- Semi-realistic art style.
- Rose model: the user has it as an **FBX, not rigged**. Plan is Blender, then rig (Mixamo for the prototype, Rigify later), then USDZ, then RealityKit (see `GAME_DESIGN.md` section 8). Open: licence, textures included, T-pose or A-pose.

## Repo and branch state
Repo: `dylanwells120-png/Lost-Xcode`. Default branch: `main`.

| Branch / PR | State |
|---|---|
| `main` | Initial README only; same commit as the tip of `claude/lost-game-design` before PR #1's last commit |
| `claude/lost-game-design` — PR #1 (draft) | Adds the Rose pipeline section to `GAME_DESIGN.md` |
| `claude/xcode-project` — PR #2 (draft) | **The branch with everything**: design doc, README, code, CI. Stacked on #1 (its base is `claude/lost-game-design`) |

Merge #1 first, then retarget #2 to `main`. Both PRs are subscribed for events.

## What's built (all on `claude/xcode-project`)
- `Package.swift`: Swift package, macOS 14+, opens directly in Xcode.
- `Sources/LostCore`: pure-Swift logic. Movement modes (speed, noise radius), `NoiseEvent` audibility, `HollowBrain` state machine (patrol, investigate, chase, search). 5 unit tests in `Tests/LostCoreTests`.
- `Sources/Lost`: Mac app.
  - `GameView.swift`: `ARView`-based RealityKit scene (ground, red capsule standing in for Rose, spotlight flashlight, follow camera) plus a HUD showing mode and noise radius. `RealityView` is not used because it needs macOS 15.
  - `InputController.swift`: GameController plus keyboard. WASD or arrows move, Shift or right trigger runs, Ctrl, C or B crouches.
  - `LostApp.swift`: sets the foreground activation policy so a Swift package app gets a window and keyboard focus.
- `.github/workflows/ci.yml`: `swift build` and `swift test` on macos-14 for PRs and pushes to `main`. **Green on the latest commit (`c2f8101`).**

## Not done / known gaps
- **Never run by a human yet.** CI proves it compiles and the unit tests pass; nobody has confirmed the window opens, the camera and movement feel right, or the keyboard works. First thing to do: run it on a Mac (Cmd+R, scheme **Lost**, My Mac) and fix whatever is off.
- Flashlight toggle (F key, controller X) is read by `InputController` (`flashlightToggled`) but not wired to the light.
- Hollow AI exists only as logic. No Hollow in the scene yet, no sound propagation wired to the player.
- Rose is a placeholder capsule. No animations, no third-person camera collision.
- No audio, saving, inventory, UI beyond the HUD, or world streaming.
- No `.xcodeproj`; the project is a Swift package. An app bundle (icon, entitlements, StoreKit for in-app purchases, App Store signing) will need an Xcode app target later.

## Suggested next steps
1. Confirm it runs on a Mac; fix any runtime problems.
2. Wire the flashlight toggle.
3. Put one Hollow in the scene driven by `HollowBrain`, hearing Rose's noise radius.
4. Import the rigged Rose (USDZ) and play idle, walk, run and crouch animations.
5. Third-person camera polish, then the Prologue level block-out from `GAME_DESIGN.md`.

## Working notes
- Cloud sandbox has no Swift toolchain and blocks swift.org, so compile checking happens through GitHub Actions on the PRs. Check the CI result after every push.
- Branch protection: the repo had no `main` at first; `main` was created from `claude/lost-game-design`.
- Commits end with the Claude co-author and session trailers.
