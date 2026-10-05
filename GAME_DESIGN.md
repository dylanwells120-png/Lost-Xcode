# LOST — Game Design & Production Outline

**Genre:** Third-person 3D narrative horror / drama, open world, post-apocalyptic
**Platforms:** Mac first (Apple silicon, controller-first); iPhone / iPad later. Built in Xcode
**Tone:** *Little Nightmares* meets *The Last of Us* meets *Inside*. Quiet, vulnerable, tense. Rose is never a fighter — she hides, sneaks, solves, and hopes.

---

## 1. Logline

When a world-ending event scatters her family, eight-year-old **Rose** wakes alone in a ruined town with a flashlight, a torn map, and a music box that hums when her family is near. She must cross a dying land to find them — and decide what she's willing to become to get there.

---

## 2. Story

### Backstory
Three years ago the **Hush** arrived: a spreading blight that silences everything it touches — birds, engines, radios, then people. Cities emptied. Survivors learned to live quietly, because sound draws the **Hollow** — people who were taken by the Hush, now shells that wander and listen.

Rose's family — **Mom (Elena)**, **Dad (Tom)**, and baby brother **Finn** — has been moving between safe houses, heading for a rumored sanctuary called **Harbor**.

### Cast
| Character | Role |
|---|---|
| **Rose** (8) | Protagonist. Curious, stubborn, afraid of the dark but learning courage. |
| **Elena** (Mom) | Former nurse. Leaves Rose clues: chalk hearts, bandage-scrap markers. |
| **Tom** (Dad) | Former engineer. Leaves radio and mechanical clues. |
| **Finn** (infant) | Why the family is desperate — he is the only child ever seen who *doesn't* attract the Hollow. |
| **Biscuit** | Rose's stray dog companion (Act 1+). Sniffs out trails, warns of danger. Never dies. |
| **Mr. Alder** | Elderly lighthouse keeper. Mentor, secretly hiding something. |
| **The Choir** | Hollow who sing instead of wander. The game's main antagonist presence. |
| **Marrow** | A survivor-scavenger. Ally or threat depending on player choices. |

### Core Mystery
The music box was Finn's lullaby box. It reacts to him — and to the Hush. Over the game, Rose learns the family's flight wasn't random: Tom discovered that Finn's immunity might be a cure, and the **Choir** (led by something that was once a scientist) wants him.

### Act Structure

**Prologue — "The Quiet Night"** (tutorial, ~20 min)
A tense, scripted family car trip at dusk. Rose dozes. A crash, a sound, a flash of light. She wakes in a wrecked car, family gone, a trail of Mom's chalk hearts leading away. Teaches: movement, flashlight, crouch, hide.

**Act I — "Small Town, Big Dark"**
*Region: Pinewood (abandoned town, school, hospital)*
- Rose learns the rules: noise attracts Hollow, light can repel them, hiding works.
- Finds **Biscuit** locked in a pet-shop cage.
- Discovers the first family sign at a school — Mom's heart plus a note: *"Go to the lighthouse. Stay quiet. We love you."*
- Mid-act reveal: a Hollow wearing Dad's jacket. (Is Dad gone? — a false alarm; he gave it away. Plants the fear.)
- Ends: crossing a collapsed bridge, Rose meets **Mr. Alder**'s radio voice.

**Act II — "The Long Road" (open-world core)**
*Regions: Rust Flats (industrial yards), Drowned Fields (flooded farmland), The Greenhouse (overgrown biodome)*
- The map opens. Rose picks her route; each region has a family clue and a story chapter.
- **Rust Flats:** Tom's workshop. Rose repairs a radio; hears a looping message from Dad.
- **Drowned Fields:** boat sequence, stealth through silent fog. Meets **Marrow**; first moral choice (share scarce food/batteries or not).
- **The Greenhouse:** the Choir's nest. Rose discovers Finn was here — and left alive. Learns the Choir hunts him.
- Midpoint twist: Rose finds Elena's journal. It reveals Elena is wounded and slowing the family down; she chose to split from them to lead the Choir away.
- Low point: Biscuit is separated; Rose is truly alone; the Hush takes her flashlight batteries. She must use sound itself — humming the lullaby — as a weapon/lure.

**Act III — "Harbor Light"**
*Region: The Coast, Lighthouse, Harbor*
- Mr. Alder shelters Rose, then reveals he has been *drawing the Hollow away* with the lighthouse beam — and that Harbor is a lie; the sanctuary is the lighthouse itself, powered by a device that repels the Hush.
- The Choir attacks. Rose must choose: lure them away with the music box (sacrificing it and her link to Finn), or hide and let Alder fall.
- Climax: Rose reunites with Dad and Finn at the top of the lighthouse; Mom is out on the rocks, calling.

### Endings (decided by accumulated choices)
1. **"Home" (Good):** Rose helps (or lures the Choir) so that Elena survives. Family reunited. The light sweeps the dark; far away, a bird sings.
2. **"Quiet" (Bittersweet):** Rose saves Finn and Tom, but Elena and the music box are lost. The family sails on.
3. **"Hollow" (Dark):** Rose, too frightened and too hardened by selfish choices, stays silent while someone is lost. She finds her family — but she's changed, and the Hush hums in her too.

### Themes
Fear vs. courage, silence vs. voice, what we sacrifice for family, the weight of children growing up too fast.

---

## 3. Gameplay Design

### Pillars
1. **Vulnerability** — Rose cannot fight. Tension comes from avoidance.
2. **Sound as mechanic** — everything Rose does makes noise; the world listens.
3. **Environmental storytelling** — the story is found in rooms, notes, drawings.
4. **Open-world hope** — freedom to explore, with a "family signal" guiding without handholding.

### Core Mechanics
- **Move / Run / Crouch / Climb** (run = loud, crouch = quiet)
- **Flashlight** (limited battery; light repels some Hollow, attracts others)
- **Hide** (lockers, under beds, tall grass)
- **Throw** (distract with bottles/cans)
- **Music box** (hum tool: calms some Hollow, angers the Choir; upgrades via story)
- **Biscuit commands** (sniff trail, bark = deliberate lure, stay)
- **Inventory** — tiny backpack: batteries, chalk, food, key items
- **Chalk** — Rose draws her own markers to remember routes (player-made breadcrumbs)

### Enemy Types
| Enemy | Behavior |
|---|---|
| **Wanderers** | Slow, patrol; react to sound radius |
| **Listeners** | Stationary; huge hearing radius, zero sight |
| **The Choir** | Group that sings; sound pulses reveal Rose; pursue relentlessly |
| **Hush Fog** | Environmental hazard; muffles all sound (also hides Rose) |

### World Structure
Hub-and-region open world: 5 regions, each ~1–2 hrs, linked by roads/boat/rail. Safe houses act as save points and story beats. Total length target: **8–10 hours**.

### Accessibility
Subtitles, closed captions for sound cues (visual noise indicator), colorblind-safe UI, adjustable difficulty (Hollow awareness), one-handed touch scheme, haptic cues for danger via Core Haptics.

---

## 4. Technical Outline — Building in Xcode

### 4.1 Technology Choices

**Recommended: Swift + SceneKit/RealityKit + GameplayKit** (native, no third-party engine) — good for a prototype and mid-sized 3D game.

| Layer | Apple Framework |
|---|---|
| Rendering | **RealityKit** (modern, ECS-based) or **SceneKit** (simpler, mature); **Metal** for custom shaders (fog, flashlight, volumetric light) |
| Game loop & app shell | **SwiftUI** + `RealityView` / `SCNView` |
| AI / pathfinding | **GameplayKit** (`GKAgent`, `GKGraph`, state machines, behavior trees) |
| Input | **GameController** (gamepads), touch joysticks, keyboard/mouse on Mac |
| Physics | RealityKit/SceneKit physics, or custom for sound propagation |
| Audio | **AVAudioEngine** + `AVAudioEnvironmentNode` for 3D positional sound; adaptive music |
| Haptics | **Core Haptics** |
| Save data | **SwiftData** or `Codable` JSON in app container; **iCloud/CloudKit** optional |
| Asset pipeline | Blender → **USDZ** (Reality Composer Pro) / `.scn`; Asset Catalogs |
| Dialogue/story | Custom JSON/YarnSpinner-style data files parsed with `Codable` |
| Analytics/Crash | MetricKit, TestFlight feedback |

> **Alternative:** If you want faster open-world tooling (terrain streaming, lighting, big asset library), build in **Unity** or **Unreal** and use Xcode only as the final iOS/macOS build target. Decision gate at the end of Phase 0.

### 4.2 Project Setup
1. Xcode → **New Project → Game** (or **App** with SwiftUI) → name **Lost**, language Swift, Metal/RealityKit.
2. Targets: **Lost (iOS)**, **Lost (macOS)** — multiplatform. Minimum iOS 17 / macOS 14.
3. Repo layout:
   ```
   Lost/
   ├── App/                 # LostApp.swift, scene setup, menus
   ├── Core/                # GameLoop, StateMachine, EventBus, SaveSystem
   ├── World/               # Region loading, streaming, chunking, time/weather
   ├── Entities/            # Rose, Biscuit, Hollow, Choir (components/systems)
   ├── Systems/             # Sound propagation, Stealth, Inventory, Dialogue
   ├── UI/                  # SwiftUI HUD, inventory, map, menus
   ├── Audio/               # Sound manager, adaptive music
   ├── Story/               # Chapters, quests, dialogue data (JSON)
   ├── Resources/           # USDZ models, textures, audio, shaders (.metal)
   └── Tests/               # Unit & UI tests
   ```
4. Use **Swift Package Manager** for modular code (e.g. `LostCore`, `LostAI`).
5. Set up **Git + .gitignore** (Xcode user data, DerivedData), **Git LFS** for large assets.

### 4.3 Architecture
- **ECS pattern** (RealityKit components/systems): `StealthComponent`, `NoiseEmitterComponent`, `HearingComponent`, `InteractableComponent`.
- **Event bus** for story triggers (`FamilyClueFound`, `EnteredRegion`).
- **State machines** (GKStateMachine): Hollow AI (`Idle → Patrol → Investigate → Chase → Search`), game (`Menu → Playing → Cutscene → Paused`).
- **Noise system**: every action emits a noise radius → AI hearing query → investigation points.
- **World streaming**: split each region into tiles/chunks loaded async to keep memory in budget on iPhone.
- **Save system**: checkpoint at safe houses + autosave on clue discovery.

### 4.4 Graphics & Atmosphere
- Stylized low-poly + strong lighting (cheaper than realism, scarier with fog/shadows).
- Single-source flashlight with soft shadows; **volumetric fog** via Metal shader/post-process.
- Dynamic time of day (dusk → night) and weather (rain, fog).
- Performance budget: **60 fps on iPhone 13+, 30 fps min on older**; LOD, occlusion, baked lighting where possible.

### 4.5 Audio
- Positional 3D audio is gameplay (players hear Hollow before seeing them).
- Dynamic music layers: calm → tension → chase, driven by AI state.
- Foley library for footsteps by surface (wood, gravel, water).
- Silence is a design tool — use it deliberately.

### 4.6 Tools & Testing
- **Instruments** (Metal System Trace, Time Profiler, Allocations) every milestone.
- **Xcode Previews** for HUD; **XCTest** for stealth/AI/save logic; **XCUITest** for menus.
- **TestFlight** playtests from vertical slice onward.
- **GitHub Actions / Xcode Cloud** for CI builds.

---

## 5. Production Roadmap

| Phase | Goal | Deliverable | Est. |
|---|---|---|---|
| **0 – Prototype** | Prove the feel | Xcode project; Rose walks in a gray-box room; flashlight; crouch; one Hollow reacts to noise | 3–4 wks |
| **1 – Vertical Slice** | Prove the game | Prologue + 1 playable block of Pinewood; full stealth loop; Biscuit; music box; save/load; polish pass | 8–10 wks |
| **2 – Pre-production** | Lock content & pipeline | Final art style guide, asset pipeline, dialogue tools, world map, all region designs, engine decision locked | 4–6 wks |
| **3 – Production** | Build the game | Regions built in order (Act I → III); story chapters; all enemy types; UI; audio; localization hooks | 6–10 mo |
| **4 – Alpha** | Feature complete | Whole game playable start-to-end, all endings, rough polish | 6 wks |
| **5 – Beta** | Stability & balance | TestFlight, performance tuning, accessibility, bug-fix | 6–8 wks |
| **6 – Release** | Ship | App Store assets, privacy labels, age rating (likely 12+/17+ for horror themes), launch trailer | 4 wks |

*(Estimates assume a small team of 2–5. Solo dev: roughly double.)*

### Team / Roles (can overlap)
Game designer/writer · Swift/gameplay programmer · 3D artist/environment · Animator/rigger · Sound designer/composer · QA/playtesters.

### Immediate Next Steps (first 2 weeks)
1. Create the Xcode multiplatform project and commit the repo structure.
2. Gray-box a character controller: walk, run, crouch, third-person camera.
3. Add flashlight + fog lighting test scene.
4. Implement noise emitter + one Hollow with `GKStateMachine` AI.
5. Add basic HUD (battery, noise indicator) in SwiftUI.
6. Write the Prologue script and block out the first level on paper.

### App Store Considerations
- Horror content → accurate age rating questionnaire.
- Avoid graphic gore (the Hollow are eerie, not gory) — keeps rating accessible and fits the tone.
- Include in-game content warnings and a pause/safe-exit option.

---

## 6. Decisions Locked

- **Engine:** fully Apple-native (Swift, RealityKit/SceneKit, Metal, GameplayKit). No Unity/Unreal.
- **Platform priority:** Mac and game controller first (Apple silicon, GameController framework). iPhone/iPad touch support comes later.
- **Business model:** one-time premium purchase plus optional in-app purchases (StoreKit 2). IAP should stay cosmetic or convenience (e.g. soundtrack, art book, outfits); never gate story or pay-to-win.
- **Art style:** semi-realistic. Keep the lighting and fog strong and keep texture and polygon budgets disciplined so it runs well on Apple silicon.
- **Rose:** an existing character model is available. First task is importing it (USDZ, via Reality Composer Pro), checking the rig and skeleton, and hooking up walk/run/crouch animations.

## 7. Open Questions
- Which format is the Rose model in (FBX, USD, Blender, other), and is it already rigged?
- Minimum Mac spec to target (e.g. M1, macOS 14)?
- Which cosmetic or convenience items should the in-app purchases offer?

---

## 8. Rose Character Pipeline (FBX, unrigged)

1. Open the FBX in Blender; check scale (~1.2 m tall), orientation and textures; apply transforms.
2. Verify the mesh: ~40-80k triangles, clean topology at joints, PBR textures (base color, normal, roughness, AO), and facial blend shapes (fear, relief, etc.).
3. Rig: start with Mixamo auto-rig for the prototype (retarget for child proportions); move to a Rigify rig if quality demands. AccuRIG is a third option.
4. Animate: Mixamo idle/walk/run/crouch/climb for the prototype; custom clips for humming, flinching and peeking.
5. Export USD/USDZ from Blender, inspect in Reality Composer Pro, load in RealityKit and play via `AnimationResource`.

Open items: confirm model ownership/licence (Mixamo terms), whether textures are included, and T-pose vs A-pose.
