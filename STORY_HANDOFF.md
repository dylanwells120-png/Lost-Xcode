# LOST — Story, Missions & Cutscene Scripts (Handoff)

Written for the session that is building the game. This document is **writing only**: no code, no assets. It extends `GAME_DESIGN.md` (sections 2 and 3) and keeps everything in it canon. Where this document adds detail, it says so. Where something is a tunable suggestion rather than a rule, it is marked **(tunable)**.

Contents
1. Lore bible (what is really going on)
2. Cast and voice notes
3. Tone rules and rating guardrails
4. Choice and ending logic
5. Mission list (Prologue to Act III)
6. Cutscene scripts (CS01 to CS16)
7. Collectibles: notes, tapes, drawings
8. Ambient barks and radio lines
9. Integration notes for the build session

---

## 1. Lore bible

**The Hush.** Three years ago a research effort called **Project Lullaby** tried to build a sound-based treatment that calms the dying and frightened (originally for a children's hospice). It was led by **Dr. Imogen Vale**. A transmitter array at **Harbor** broadcast the treatment tone. It went wrong: the tone did not calm people, it *emptied* them. Anyone who heard it for long enough stopped speaking, then stopped being themselves. Sound itself began to feel dangerous. The blight spread because the tone spread: radios, then wind, then people carrying it.

**The Hollow.** People who heard too much. They do not hate and they do not hunt out of hunger. They listen, and they move toward sound because sound is the only thing left that feels familiar. Never gory. Pale, still, faintly humming, wearing the clothes they had on. Some stand facing walls for days.

**The Choir.** Hollow who were once Vale's own patients and staff. They do not wander; they *sing*, a layered, wordless version of the treatment tone, and they gather. Their song makes ordinary Hollow follow them. The Choir is looking for one thing: a sound that **matches** their tone exactly and can finish it. That sound is a child's lullaby hummed on a particular music box.

**Finn.** Finn was one of Vale's youngest hospice patients, adopted by Elena and Tom after the clinic closed (Elena was a nurse there). He is Rose's baby brother in every way that matters, and Rose has never been told he is adopted. Finn does not go Hollow because the music box was his lullaby from birth: he has been "tuned" against the tone his whole life. The music box plays the **counter-tone**. The Choir does not want to hurt Finn; they want to complete their song, and the box (and Finn) is the missing note. In the wrong hands that ends in more Hollow, not a cure.

**The music box.** Brass, scratched, a small painted rose on the lid. Tom built it from a clinic prototype and gave it to Elena for Finn. It hums when Finn is near because the prototype resonates with him. Rose has carried it since the crash because Finn dropped it in her lap before the car went off the road. (Reveal in CS01.)

**Harbor.** The rumored sanctuary is a lie. Harbor was the transmitter site. The "come to Harbor" radio message is Mr. Alder's looping broadcast, recorded to draw survivors **away from the Choir's territory** toward the lighthouse, which has the only working counter-tone emitter. It also drew the Choir. He has lived with that guilt for three years.

**The lighthouse.** Alder's old keeper's post doubles as the last working counter-signal emitter. The big lamp is not just light: it pulses the counter-tone across the bay, which keeps the Hush out of a few kilometers around it. It runs on a failing generator and needs Finn's tone to be stable. That is why Tom, Elena and Finn are heading there.

**Mom's wound.** Elena was hurt escaping the Greenhouse (the Choir's nest). She knows she is slowing the family. She splits off to pull the Choir away from Tom and Finn. She leaves chalk hearts and her journal for Rose to find.

**Dad's jacket.** Tom gave his jacket to a freezing stranger in Pinewood before crossing the bridge. The Hollow wearing it in CS04 is that stranger, now lost to the Hush. Rose thinks it is her father. It is a false alarm, but the scene should leave her shaking.

### Timeline (fixed)
- 3 years ago: Project Lullaby fails. The Hush begins.
- 2.5 years ago: Elena, Tom, Rose and baby Finn leave the city.
- 1 year ago: Alder starts the Harbor broadcast.
- Game start: the family's car goes off the road outside **Pinewood** at dusk.

---

## 2. Cast and voice notes

| Character | Age | Voice / manner | What they want |
|---|---|---|---|
| **Rose** | 8 | Quiet, dry, stubborn. Speaks little, whispers in the dark. Asks small blunt questions. Never wisecracks; when she is funny it is by accident. Voice breaks only at the big beats. | Find her family. Secondary: be brave without anyone seeing her be scared. |
| **Elena (Mom)** | late 30s | Warm, practical, nurse-calm. Gives instructions as comfort. Hums when she is afraid. | Keep her kids safe. Will pay any price. |
| **Tom (Dad)** | early 40s | Gentle jokes under stress, mechanic's patience, says "okay, okay, okay" when thinking. | Get Finn to the lighthouse. Believes he is running out of time. |
| **Finn** | 10 months | Babbling, laughing, never cries when the tone is near (a clue). No dialogue. | n/a |
| **Biscuit** | dog | No dialogue. Whines, huffs, tail and ear performance only. | Rose. |
| **Marrow** | ~19 | Gruff, wary, funny when he forgets to be guarded. Short sentences. Calls Rose "kid" until he earns "Rose". | Survive; atone for something he will not say. |
| **Mr. Alder** | 70s | Gentle, formal, slightly poetic. Speaks to Rose as to a colleague. Radio voice is warmer than his real voice. | Finish what he started; be forgiven. |
| **Dr. Imogen Vale** | n/a | Recorded voice only (tapes). Clinical, tender, deeply wrong. | n/a |

Rose's family nickname for each: Mom = "Mama", Dad = "Dad", Finn = "Finny".

---

## 3. Tone rules and rating guardrails

- Horror from **sound, absence, and dread**, not blood. No graphic violence, no injury close-ups, no jump-scare gore.
- Rose never fights, never kills. She hides, distracts, calms.
- No Hollow is ever shown being harmed. If one is "freed", it is shown standing still and quiet, not dying.
- Dead bodies are not shown. Absences (empty beds, a single shoe, a chalk circle) carry the weight.
- Family scenes must feel warm enough that the dark is frightening. Give every act at least one moment of gentle humor or tenderness.
- Rose may be afraid, cry, and shake. She does not scream in gameplay unless a scripted beat calls for it.
- Content notes for the store page: fantasy violence (mild), scary themes, loss of family.

---

## 4. Choice and ending logic **(tunable)**

### The Heart score
Track a single integer, **HEART** (0 to 4), from four optional choices. Each is quiet: no on-screen "good/evil" banner.

| ID | Where | Choice | Heart +1 if... |
|---|---|---|---|
| H1 | Mission 1.3, hospital | Leave half the batteries for whoever comes next | Rose leaves half |
| H2 | Mission 2.3, Tune the Tower | Spend time broadcasting a message for other lost children instead of rushing on | Rose sends the message |
| H3 | Mission 2.5, Marrow's Barn | Share food and batteries with Marrow | Rose shares |
| H4 | Mission 2.8, the Nest | Go back for Marrow when the Choir wakes | Rose goes back |

### Other tracked flags
- `BISCUIT_WITH_ROSE` (true until Mission 2.10, then false until Mission 3.1).
- `MARROW_ALIVE` (false only if H4 is declined; see Mission 2.8).
- `HEARD_DAD_TAPE`, `READ_JOURNAL` (both always true by the midpoint; used for dialogue variants).
- `CLIMAX_CHOICE`: `SING` or `HIDE`.

### Ending resolution
| Condition | Ending |
|---|---|
| `CLIMAX_CHOICE = SING` and HEART >= 3 | **HOME** (good): CS14A |
| `CLIMAX_CHOICE = SING` and HEART <= 2 | **QUIET** (bittersweet): CS14B |
| `CLIMAX_CHOICE = HIDE` | **HOLLOW** (dark): CS14C |

Notes:
- The player should reach the climax choice **without being told** that earlier choices matter.
- Hiding must be an honest, tempting option (the game has taught hiding all along). CS13 sets that trap on purpose.
- HOME and QUIET share most of CS13 and CS14; the ending cutscene branches after the song.

---

## 5. Mission list

Format: **ID, name**: region. Goal. Beats. Teaches / uses. Cutscenes. Collectibles. Choice/flag.

### PROLOGUE — "The Quiet Night" (about 20 min)

**P.1 — Wake Up**: wrecked car, roadside, Pinewood outskirts, dusk.
- Goal: get out of the car, find the flashlight in the glove box.
- Beats: CS01 plays first (the drive, the crash). Gameplay begins with Rose in the back seat, the car on its side. She frees herself, finds her family gone, the music box in her coat.
- Teaches: movement, camera, interact, flashlight toggle.
- Cutscenes: CS01 (before), CS02 (short, on exiting the car).

**P.2 — Follow the Hearts**: the road to the town edge.
- Goal: follow Mom's chalk hearts along the road to the first building.
- Beats: three hearts in a row, each one a little fainter; a distant humming; first Wanderer seen standing in a field, motionless. The game teaches crouch by making Rose pass within earshot.
- Teaches: crouch, noise radius (HUD shows it), hiding in tall grass.
- Collectible: a child's drawing (see 7).
- Ends with: the Pinewood town sign; the title card **LOST**.

### ACT I — "Small Town, Big Dark" (region: Pinewood)

**1.1 — Hearts to the School**: Pinewood Main Street.
- Goal: find the next heart; it points toward the school.
- Beats: abandoned shops; a Listener Hollow facing a dead traffic light (huge hearing radius, no sight); Rose learns to throw a can to pull it away.
- Teaches: throw, Listener behavior, route planning with chalk (Rose can draw her own hearts; the game explains this).

**1.2 — The Cage**: Pinewood Pet Shop.
- Goal: get through the back door.
- Beats: scratching sounds inside; a locked dog crate and a stray in it. Rose finds a key behind the counter (hidden under a stuffed toy).
- Cutscene: CS03 (Biscuit).
- Result: **Biscuit joins**. Gameplay: sniff-trail command and a warning growl when Hollow are near.

**1.3 — Lights Out**: Pinewood General Hospital (small clinic, ground floor and basement).
- Goal: reach the basement supply room for batteries.
- Beats: dark corridors, flashlight battery drains while Rose's light reveals things; a Hollow in a gown stands at a nurse's station. Rose finds Mom's old badge on a hook ("E. Marsh, RN"), and a note in Mom's handwriting: *"Rose, if you find this: school. Quiet. We love you."* The basement has one pack of four batteries and a handwritten sign: **"Take what you need. Leave some for whoever comes next."**
- **Choice H1**: Rose may take all four or leave two. (Both allowed. Taking all gives longer flashlight life in Act I; leaving two gives Heart +1.)
- Teaches: battery management, hiding in cabinets, chalk as breadcrumbs.

**1.4 — The Jacket**: Pinewood Elementary.
- Goal: reach Mom's second clue in the classroom (her heart plus the note she left: *"Go to the lighthouse. Stay quiet. We love you."*).
- Beats: school corridors; children's coats still on pegs; the classroom has a drawing taped to the board of a family of four stick figures and a baby, with a small lighthouse on a cliff. Mid-mission, CS04: a Hollow wearing Dad's jacket in the playground below.
- Cutscene: CS04 (Dad's Jacket).
- After: a long, tense exit while the Hollow in the jacket lingers by the swings, humming. Rose must pass it by humming nothing at all (hold crouch near silence).

**1.5 — The Bridge**: Route 9 river crossing.
- Goal: cross the collapsed bridge (use a fallen billboard as a ramp).
- Beats: a first chase set-piece, short and readable: a pair of Wanderers drift toward the sound of Rose's footsteps on metal; the player must cross in quiet bursts.
- Cutscene: CS05 (Alder on the Radio), played as Rose finds a roadside emergency phone/radio.
- End of Act I.

### ACT II — "The Long Road" (open world: three regions, any order)

After the bridge, the map opens. Mom's heart-trail, Dad's radio fragments, and Alder's voice each point somewhere different. The family trail naturally leads **Rust Flats, then Drowned Fields, then the Greenhouse**, but the player may take the regions in a different order. The three regions share three required story missions each, but their *cutscenes* must stay in the fixed order below (the game gates the cutscene, not the exploration).

#### Region A — Rust Flats (industrial yards)

**2.1 — Across the Yard**: rail yard.
- Goal: cross the yard to Dad's workshop without waking the Listeners standing among the stopped train cars.
- Teaches: moving between cover, using moving train cars as sound cover (a creaking car masks footsteps).

**2.2 — The Workshop**: Tom's workshop.
- Goal: get the old radio working: find a fuse, a battery, and a coil, each hidden in a different corner of the workshop.
- Beats: Rose finds a marked-up map of the coast with the lighthouse circled; photos of the family; a half-finished toy (a wooden dog) he was making for Rose.
- Cutscene: CS06 (Dad's Message), triggered when the radio turns on and a tape loops.
- Flag: `HEARD_DAD_TAPE = true`.

**2.3 — Tune the Tower**: radio tower above the yard.
- Goal: climb the tower and re-aim the antenna so Rose can hear farther.
- **Choice H2**: with the radio live, Rose can spend a few minutes (the player has to stand still and speak a message into the old microphone) broadcasting for **other lost children**: where she is, where the safe houses are. It costs time and battery. Alternatively she can climb down and leave.
- Rewards: a map update (shows safe houses) either way; if H2 is chosen, a later radio voice from a child says "I heard you, Rose" (CS12 environmental line).

#### Region B — Drowned Fields (flooded farmland, fog)

**2.4 — The Boat**: flooded road.
- Goal: find a rowboat and oars.
- Teaches: boat movement (rowing is loud, drifting is quiet, fog hides Rose and the Hollow equally).
- Beats: floating farm signs, a half-sunk tractor, a scarecrow that makes Rose stop breathing for a second (it is only a scarecrow).

**2.5 — Marrow's Barn**: raised barn on a hill.
- Goal: reach the barn, where the family's next heart is drawn on the door, and a stranger's boot prints lead inside.
- Cutscene: CS07 (Marrow).
- **Choice H3**: Marrow is out of food and batteries. Rose can **share** (costs supplies) or **keep** them. Both are survivable.
- Result: Marrow offers to guide Rose through the fog fields in exchange for her flashlight for one night, or alone if she shared.

**2.6 — Fog Run**: the fields at night.
- Goal: reach the far fence line.
- Beats: a long, quiet stealth sequence where sound carries oddly; Marrow (if present) taps the shoulder to signal stops. A single Choir voice somewhere in the fog, far off, singing the first two notes of the lullaby. Rose freezes. This is the first time the player hears the song.

#### Region C — The Greenhouse (overgrown biodome, Choir nest)

**2.7 — Through the Glass**: biodome exterior.
- Goal: find a way in; the main doors are chained. Rose goes through a drainage tunnel.
- Beats: green light through broken glass panels, vines inside; the sound design here is nearly pure silence, with the Choir's low chord underneath.

**2.8 — The Nest**: biodome interior.
- Goal: find Mom's trail, which ends at a bench with her bandage scraps and a bloodless red scarf; then the drawer of the old caretaker's desk holds Elena's journal.
- Beats: Hollow stand in rows among the plants, facing the center where a ring of chairs surrounds a small, empty cradle. This is where Finn was kept for a night. The Choir slowly wakes as Rose steps on a pane of glass.
- Cutscene: CS08 (Finn Was Here), then CS09 (Elena's Journal) after Rose escapes.
- **Choice H4**: if Marrow came with Rose, he is caught behind a collapsing greenhouse door. She can run on, or go back and use the lullaby box to hum a safe path for him. Going back is dangerous (Choir pulses). If Rose runs, `MARROW_ALIVE = false` (he is gone from the story; Act III has an empty space where his help would have been).
- If Marrow never joined (Rose went alone), H4 auto-resolves as Heart +1 only if H3 was granted, otherwise 0. **(tunable)**

**2.9 — The Journal**: a quiet place to read (a rooftop shack above the Greenhouse).
- Goal: read Elena's journal. The player reads entries in the HUD; Rose reads aloud, in a whisper, as a voiceover.
- Cutscene: CS09.
- Flag: `READ_JOURNAL = true`. Rose learns Elena split off to lead the Choir away.

**2.10 — Alone**: the road away from the Greenhouse, rain.
- Goal: find shelter. Biscuit is separated when Rose hides from a Choir sweep and the dog runs the other way to draw them (he is fine; he is found again in 3.1).
- Rose's flashlight dies: the Hush "drinks" the last battery (a scripted event). Without light, Rose must navigate by sound and by the music box's faint hum.
- Cutscene: CS10 (Alone).
- Teaches the final mechanic: **hum**. Humming the lullaby calms ordinary Hollow within a small radius but angers the Choir.

**2.11 — The Lullaby**: night road to the coast.
- Goal: cross a long stretch of open road using only humming and darkness.
- Beats: a quiet, beautiful, terrifying sequence. At the end, the sea and the lighthouse lamp appear on the horizon, sweeping.

### ACT III — "Harbor Light" (region: the Coast)

**3.1 — The Shore Road**: cliffside road.
- Goal: reach the lighthouse path.
- Beats: Biscuit rejoins at a washed-up fishing hut (a warm payoff, no cutscene needed, a short in-engine moment: he sprints and slides into her). If `MARROW_ALIVE`, Marrow rows round the point and meets her at the jetty.
- Flag: `BISCUIT_WITH_ROSE = true`.

**3.2 — The Climb**: the lighthouse stairs.
- Goal: climb 200 steps while the lamp sweeps. The sweep forces rhythm: move when the beam is away, freeze when it passes.
- Beats: rooms along the stairs tell Alder's three years: a table set for two, a wall of tallied days, a drawer of children's drawings Alder collected from the road.

**3.3 — The Lamp Room**: top of the lighthouse.
- Goal: meet Mr. Alder.
- Cutscene: CS11 (The Keeper) and CS12 (What the Light Does).

**3.4 — The Choir Comes**: the whole lighthouse, then the rocks.
- Goal: survive the night. The Choir arrives in a slow tide across the causeway. Tom and Finn are in the lamp room; Elena's call comes from the rocks below.
- Cutscene: CS13 (The Choice).

**3.5 — The Song**: causeway and rocks (this is the only sequence that depends on `CLIMAX_CHOICE`).
- SING: Rose carries the music box down to the rocks, hums, and walks the Choir away from the lighthouse in a long, slow procession. Biscuit (and Marrow, if alive) keep the path.
- HIDE: Rose crouches in the lamp-room cupboard; the player hears the world go on without her.
- Cutscene: CS14A, CS14B or CS14C, then CS15 (epilogue stinger) and credits.

CS16 is the post-credits scene (see below).

---

## 6. Cutscene scripts

Screenplay format. **VO** is voice-over. **(O.S.)** is off-screen. Camera and sound notes are in italics for the director, not for the player. "Hold" means hold the shot. All timings are suggestions. Rose's lines are intentionally few.

---

### CS01 — "The Quiet Night" (Prologue, about 4 min)

*A rainy dusk. Interior of a battered family station wagon, headlights cutting a two-lane road through pines. No music. Engine, wipers, rain.*

**INT. WAGON — NIGHT**

*Rose (8) is in the back seat, curled against the window, a canvas coat over her. Finn (10 months) is in a car seat beside her, awake, babbling. Elena drives. Tom is in the passenger seat, a road map folded on his knee.*

TOM
Okay, okay, okay. If we make the coast by morning, we're ahead.

ELENA
We're not ahead. We're less behind.

TOM
That's what I said.

ELENA
It is not what you said.

*Tom turns, grinning at Rose in the mirror. Rose does not smile, but her eyes do.*

TOM
Rosie. Judge. Was that what I said?

ROSE
(sleepy)
I wasn't listening.

TOM
Wise.

*Finn laughs. A little brass music box in Finn's lap plays three soft notes. Elena glances at it in the mirror, then at the dashboard clock.*

ELENA
Don't let him drop that.

ROSE
He won't.

*She tucks the box back into Finn's tiny hand, and he squeezes it.*

*Beat. The wipers. Tom studies the map. The road ahead is empty. Then the radio, which has been off for hours, crackles on by itself: a thin, high, wordless hum. Elena's hands tighten on the wheel.*

ELENA
(low)
Tom.

TOM
I see it.

ELENA
Turn it off.

*Tom turns the knob. The hum does not stop. It is not coming from the radio any more. It is coming from outside. Rose lifts her head.*

ROSE
Mama, what is that?

ELENA
(calm voice, nurse voice)
It's nothing, baby. Put your head down and hum with me. Do you remember? The little light song.

*Elena begins to hum Finn's lullaby. Rose hums with her. Finn goes quiet and listens. Outside, headlights fall on a figure standing in the road, perfectly still.*

TOM
Elena--

*Elena swerves. The car leaves the road. Tires, branches, a long slide. Hard cut to black. Hold on black for three seconds. We hear only Finn's laugh, small and bright, then nothing.*

**INT. WAGON — LATER**

*The car is on its side. Rain on the windshield. Rose's eyes open. Her coat is over her; someone tucked it round her. The seat beside her is empty. Finn's car seat is empty. The music box lies in the crook of her arm, still warm.*

*She stays very quiet. She listens. We hear nothing but rain.*

ROSE
(whisper)
Mama?

*Nothing. Hold. Fade to gameplay.*

---

### CS02 — "Chalk Heart" (Prologue, under 1 min, plays when Rose exits the car)

**EXT. ROADSIDE — DUSK**

*Rose climbs out through the broken rear window. She stands in the rain with a flashlight she found in the glove box. The beam finds, on the wet asphalt, a heart drawn in chalk. Rain is already blurring it.*

*She kneels. Touches it. A second heart a few steps beyond it. A third.*

ROSE
(whisper, to herself)
Okay. Okay, okay, okay.

*(A tiny, accidental echo of Dad.) She stands and follows the hearts. We hold on her small silhouette against the dark road. Title: LOST.*

---

### CS03 — "Biscuit" (Mission 1.2, about 2 min)

**INT. PET SHOP — DUSK**

*Dust, silence, a row of empty cages. Rose edges in, flashlight low. A soft metallic rattle. At the far end, a crate with a latch. Inside, a small, scruffy brown-and-white dog with one ear up and one ear down. He sees her. He does not bark. He presses his nose against the grate and whines very quietly.*

ROSE
(barely audible)
Shh.

*The dog stops at once. He understands. Rose looks around for the key. She finds it under a stuffed rabbit on the counter. She crosses back, hands shaking, and tries to fit the key. It sticks.*

*Somewhere outside, something knocks against a window. Rose freezes. The dog freezes. Both listen. The knocking stops.*

*She turns the key. The latch clicks. The door opens. The dog does not rush out. He steps out carefully, leans against her shin, and puts his chin on her knee.*

ROSE
(whisper)
You're not allowed to bark. That's the rule.

*The dog's tail thumps once against the floor, as quiet as he can make it.*

ROSE (CONT'D)
(a beat)
Your name is Biscuit.

*Biscuit looks up as if he has already known this for years.*

*Cut to: the shop window. A pale figure passes outside. Rose and Biscuit duck behind the counter together. We hold on both of them, breathing, side by side.*

---

### CS04 — "Dad's Jacket" (Mission 1.4, about 2 min)

**INT. SCHOOL CLASSROOM — DUSK**

*Rose is by the window of a second-floor classroom, reading Mom's note on the wall. Below, in the playground, something moves: a figure by the swings.*

*She looks. The figure is in a brown canvas jacket, the collar turned up, the same corduroy collar as Dad's. One sleeve is patched with silver tape. Rose stops breathing.*

ROSE
(whisper)
Dad?

*She presses against the glass. The figure turns slowly toward the school. Its face is pale and calm, its mouth very slightly open. It is humming one long, even note.*

*Rose shakes her head.*

ROSE (CONT'D)
No. No, no, no.

*She runs from the window, then back. Biscuit pulls at her sleeve and growls very softly. Rose crouches and hugs him, shaking, hiding her face in his fur.*

ROSE (CONT'D)
(muffled)
It's not him. It's not him. It's his jacket.

*Beat. She wipes her face with her sleeve. Looks at the heart drawn on the blackboard. Gets her breath. Picks up the flashlight.*

ROSE (CONT'D)
(quietly)
He wouldn't let go of his jacket. He wouldn't. Not unless somebody needed it.

*She goes. We hold on the empty window. Outside, the figure in the jacket stands by the swings, one swing moving gently beside it in the wind.*

*Direction note: the game must not confirm what happened to the jacket until Mission 2.2, when Rose finds a photograph of Dad handing the jacket to a shivering stranger (a snapshot Mom took).*

---

### CS05 — "Alder on the Radio" (Mission 1.5, about 2 min)

**EXT. ROUTE 9 — NIGHT**

*Rose and Biscuit have crossed the broken bridge. On the far bank stands a rusted emergency-call box with a small speaker. As Rose passes it, the speaker crackles. A warm old voice comes through the static.*

ALDER (V.O.)
(radio)
...to anyone who can hear this. If you are lost, if you are alone, come to the lighthouse on the coast road. Follow the light. Keep your voices low. You are not the only one...

*Rose stops, looks at the box. Biscuit tilts his head.*

ALDER (V.O.) (CONT'D)
This message repeats.

*Rose presses the button on the box. A tiny red light comes on.*

ROSE
(whisper)
Hello?

*Static. Then, softly:*

ALDER (V.O.)
(a pause, surprised, then gentle)
Hello. Yes. I am here. Do not shout. Tell me your name, little one.

ROSE
(a long beat, then)
Rose.

ALDER (V.O.)
Rose. That is a good name. Is anyone with you?

ROSE
Biscuit.

ALDER (V.O.)
(a small, warm laugh)
Then you are in good company. Rose, listen carefully. Keep to the road by the water. Do not go through the fields at night. And do not run when you hear them. They hear running.

ROSE
Who is "them"?

*A long silence on the line.*

ALDER (V.O.)
(softly)
I think you already know. The lighthouse will keep you safe. It is not close. But it is not too far. Will you come?

*Rose looks at Biscuit, then at the road ahead. She presses the button.*

ROSE
My family is going there.

ALDER (V.O.)
(a different quality in his voice, quieter, as if he has just been told a secret)
Then I will keep the lamp lit.

*The line goes dead. Rose and Biscuit walk on. Behind them, the red light on the call box fades.*

---

### CS06 — "Dad's Message" (Mission 2.2, about 3 min)

**INT. WORKSHOP — DAY (grey, dusty light)**

*Rose has just repaired the old field radio. It crackles, hums, and a small spool-to-spool tape deck beside it clicks on. A tape begins to turn. Tom's voice, warm and a little tired, recorded in this room a long time ago.*

TOM (V.O.)
(tape)
Okay. Is this thing on? Okay, okay, okay.

*Rose sits slowly on a stool among Tom's tools. Biscuit lies down at her feet.*

TOM (V.O.) (CONT'D)
Rosie, if you're listening to this, then I either figured out how to leave you a message, or Mom did. Hi. I'm sorry I'm not here. I want you to know a few things.

*Rose turns the little wooden dog Tom was carving in her hands.*

TOM (V.O.) (CONT'D)
One. You're braver than me. I'm not just saying it. I've watched you walk into a dark room because you thought your brother was in it.

*Rose half-smiles for the first time in the game.*

TOM (V.O.) (CONT'D)
Two. Don't ever think quiet means scared. Quiet means you're listening. Listening is how you win.

TOM (V.O.) (CONT'D)
Three. The box in Finn's hands, the one that hums, it's not a toy. If it ever gets away from us, you keep it. You keep it close. It knows him. It'll lead you to us.

*Rose takes the music box from her coat and holds it. It hums faintly. She looks at it for a long moment.*

TOM (V.O.) (CONT'D)
(a breath, then lightly)
And four. When you find me, I'm going to be so embarrassed about the jacket story.

*Rose frowns.*

TOM (V.O.) (CONT'D)
(laughing at himself)
Long story. A man was cold. You'll understand.

*A pause. The tape hisses.*

TOM (V.O.) (CONT'D)
We're going to the lighthouse, Rosie. Mom knows a man there. A good man. He'll keep us safe. I'll see you soon. I love you. Okay, okay, okay.

*Click. The tape ends. Rose looks at the photograph pinned above the bench: Dad handing his brown jacket to a shivering stranger, Mom laughing behind the camera. Her face changes. She understands.*

ROSE
(quietly)
Oh.

*She wipes her eyes, pockets the wooden dog, and stands. Biscuit stands with her. They leave.*

---

### CS07 — "Marrow" (Mission 2.5, about 3 min)

**INT. BARN — NIGHT**

*A lantern. A barn loft with a rope ladder. A shape in the shadows. A voice, not loud.*

MARROW (O.S.)
Don't take another step.

*Rose freezes. Biscuit growls low. From the dark steps a young man (19), thin, hood up, holding a rusty crowbar like he has never needed to swing it.*

MARROW
You alone?

ROSE
(a beat)
I have Biscuit.

MARROW
(looks at the dog)
That's a dog, kid.

ROSE
He's very good.

*Marrow stares at her. Something in him loosens. He lowers the crowbar.*

MARROW
Where are your parents?

ROSE
Lighthouse. I think.

MARROW
(a short, humorless laugh)
Sure they are. Everybody's going to the lighthouse. Nobody's coming back.

ROSE
(simply)
You are a very cheerful person.

*A real laugh escapes him before he can stop it. He wipes his mouth, embarrassed.*

MARROW
Marrow. My name's Marrow.

ROSE
Rose.

MARROW
(nods)
Rose. Okay. You hungry?

*Rose does not answer. Biscuit's stomach growls loudly. Marrow looks at the dog.*

MARROW (CONT'D)
(dry)
That settles it.

*He opens his pack. It is almost empty. A heel of bread, one dead flashlight. He holds them out, not offering exactly, just showing her.*

MARROW (CONT'D)
That's all I've got. I wouldn't ask. But I haven't eaten in two days, and I can't see in the fog. If you've got anything...

*GAMEPLAY: H3. The camera holds on Rose. A short pause. The player chooses whether to share or keep her supplies.*

**IF SHARE:**

*Rose opens her bag and hands over half of her food and one battery. Marrow stares at it.*

MARROW
(quietly)
Why?

ROSE
(shrugs)
Mom says you leave some for whoever comes next.

MARROW
(clears his throat, looks away)
...Your mom sounds all right.

**IF KEEP:**

*Rose keeps her bag shut. Marrow nods slowly, hurt but unsurprised.*

MARROW
Yeah. I get it. Fair.

*Rose looks at the bread in his hand, then at Biscuit, then away. A beat of guilt.*

**BOTH BRANCHES (merge):**

MARROW (CONT'D)
(a breath)
Fog's bad tonight. Worse out in the fields. There's a way through, if you know the fence line. I know the fence line.

ROSE
Can you show me?

MARROW
(shoulders, resigned)
Yeah. Okay, kid. At dawn.

*He turns the lantern down. Rose lies down on a hay bale with Biscuit curled against her. In the dark, the music box hums. Marrow glances toward the sound, curious, suspicious. Rose pretends to sleep. He pretends not to notice.*

---

### CS08 — "Finn Was Here" (Mission 2.8, about 2 min)

**INT. GREENHOUSE — INNER CIRCLE — NIGHT**

*A ring of Hollow stand among the vines, motionless, all facing inward. In the center, a ring of small plastic chairs, and in the middle of the ring, an empty wicker cradle with a blue blanket.*

*Rose steps into the ring, the flashlight low. The Hollow do not react. They hum, a long layered chord that makes the air feel thick.*

*She kneels by the cradle. On the blanket: a tiny wooden teething ring. Finn's. She picks it up. Holds it. The music box in her pocket hums louder.*

ROSE
(barely audible)
Finny.

*Behind her, the faintest rustle: a Hollow in a white coat has turned its head very slightly toward her. Its eyes are closed. Its lips move, not speaking, shaping a lullaby that Rose recognizes.*

*She stands very slowly. She sees the other Hollow have turned too. All of them, one degree at a time.*

*Music: the layered chord tightens, then breaks. Glass shatters somewhere. The ring of Hollow open their mouths, and the full Choir sings its first full chord, a vast, beautiful, horrifying sound.*

*Rose runs. Biscuit (and Marrow, if present) run with her.*

*(Gameplay: Mission 2.8 escape sequence, including choice H4.)*

---

### CS09 — "Elena's Journal" (Missions 2.8 and 2.9, about 4 min)

**EXT. ROOFTOP SHACK — NIGHT / DAWN**

*Rain stops. Rose is sitting under a tin roof with Biscuit's head on her lap. She opens a leather journal with a nurse's pen clipped to it. Elena's handwriting. As Rose reads, Elena's voice speaks the words, a half-whisper, warm and tired.*

ELENA (V.O.)
Day 904. We have crossed the river. Finn laughed for the first time in days. I pretended not to notice that the box is humming.

*Rose turns a page.*

ELENA (V.O.) (CONT'D)
Day 920. Tom says the signal is following us. I think it follows Finn. I think it always has. I should have told Rose long ago that Finn's lullaby is not an ordinary lullaby.

*Rose stops. She looks at the music box.*

ELENA (V.O.) (CONT'D)
Day 931. We found the biodome. The people are singing. I know that song. I know every note. I worked in the room where it was written.

*Rose turns another page. There is a photograph tucked inside: Elena in nurse's scrubs standing with a group of smiling staff beside a banner that reads PROJECT LULLABY. A woman in a white coat stands at the center, one hand on a small child's head. The child is Finn as a newborn.*

ELENA (V.O.) (CONT'D)
Day 935. Imogen Vale used to hum to the children before they slept. I never thought of it as dangerous. I only thought it was kind.

*Rose looks at Biscuit. Biscuit looks at her.*

ELENA (V.O.) (CONT'D)
Day 940. I was hurt today. It is not bad. It is not good. I know I am slowing them down. Tom pretends I am not. He carries both of us.

*A slow push-in on Rose's face as she turns the final page.*

ELENA (V.O.) (CONT'D)
Day 941. I am going to lead them away. The Choir follows me. They always follow me. They remember me. If I hum, they follow. If I walk slowly, they follow slowly. Tom and Finn can reach the lighthouse. I will find them there. I promise.

*Beat.*

ELENA (V.O.) (CONT'D)
Rose, if you read this. I am sorry I did not tell you everything. You are the bravest thing in my life. And you are not alone. I left hearts so you would always know which way I went.

*Rose closes the book against her chest. She does not cry. She stares at the horizon, where the first light is coming up and, very far off, a faint white flash sweeps across the clouds: the lighthouse.*

ROSE
(whisper)
I'm coming, Mama.

---

### CS10 — "Alone" (Mission 2.10, about 3 min)

**EXT. COUNTRY ROAD — NIGHT, HEAVY RAIN**

*Rose and Biscuit crouch under an overturned truck bed as a pale line of Choir moves slowly past on the road. Their song is everywhere. Rose clamps her hand over her own mouth to stop herself from humming back.*

*Biscuit stiffens. He looks at her, then at the Choir, then at the road. He understands what he can do. He gives Rose a long, steady look.*

ROSE
(whisper, understanding)
No. Biscuit. No. Stay.

*He licks her face once. Then he bolts out from under the truck, barking loud and clear, in the opposite direction. The Choir turns, as one, and follows his sound across the field.*

ROSE (CONT'D)
(a cry she cannot help)
BISCUIT!

*Too loud. She clamps her mouth shut again. But the Choir does not hear her; the dog is farther, louder, and they are chasing him. Within seconds, the field is empty, the song fading, the rain loud again.*

*Rose crawls out. Alone. The flashlight in her hand flickers once, twice, and goes out. She presses the switch over and over. Nothing. She holds it in the dark, and for the first time we hear her cry.*

*She sits in the mud. She is eight years old. The dark is total.*

*Then, very faint, a small steady sound: the music box. It is humming. She takes it out. It glows with a faint amber light, just enough to see her hands.*

ROSE
(sniffling, a small voice)
Okay.

*She wipes her face. Stands. She holds the box in front of her like a lantern.*

ROSE (CONT'D)
(a whisper to the dark)
Okay, okay, okay.

*She begins to hum the lullaby, very softly. At first it shakes. Then it steadies. The amber light grows. On the far horizon, as if in answer, the white sweep of the lighthouse crosses the sky.*

*She walks toward it.*

---

### CS11 — "The Keeper" (Mission 3.3, about 3 min)

**INT. LIGHTHOUSE — LAMP ROOM — NIGHT**

*A huge brass lens turns slowly overhead. The room is warm and cluttered with maps, cups, and a ham radio. At the window stands an old man in a wool coat, his back to us.*

ALDER
(without turning)
You climbed the stairs very quietly.

*Rose enters, music box glowing in her hand, Biscuit's absence heavy in her chest if the dog is not with her, his presence warm at her side if he is.*

ROSE
You're the radio man.

ALDER
(turns, smiling gently)
And you are Rose. I have kept the lamp lit for you. For all of you.

*He gestures to a chair. She does not sit.*

ROSE
Where's my family?

*Alder's smile fades. He nods toward the spiral staircase that leads up to a smaller room.*

ALDER
Your father is above. Your brother is asleep. They arrived two nights ago. Your mother...

*Rose takes a step toward the stairs.*

ALDER (CONT'D)
(gently)
Wait. Please. Before you go up. I owe you the truth. I owe all of you the truth, and I have been afraid to give it.

*Rose stops. The lens turns. Light passes across his face, then dark, then light.*

---

### CS12 — "What the Light Does" (Mission 3.3, continued, about 4 min)

**INT. LIGHTHOUSE — LAMP ROOM — NIGHT (continuous)**

ALDER
There is no Harbor. There never was. The signal everyone speaks of, "come to Harbor," that was me.

*He sits, heavily, in an old wooden chair.*

ALDER (CONT'D)
Three years ago I was a technician at Harbor Station. I built the antenna. I did not ask what the signal was for. When it began to fail, I tried to turn it off. I was too late.

*Rose listens, motionless.*

ALDER (CONT'D)
After the Hush, I came here. The lighthouse has an old emitter, one that Dr. Vale's team made as a safeguard. It broadcasts the opposite of what we broke. A counter-tone. But it is weak. It needs a steady note to hold it. A child's note. Your brother's.

ROSE
Finn.

ALDER
(nods)
Your father found me last winter. He told me what he had found: that Finn is the only child the Hush leaves alone. I told him he was right. I told him I could save him if he brought him here.

*He lifts his eyes to hers.*

ALDER (CONT'D)
But I also made a broadcast. A foolish, guilty broadcast. "Come to Harbor." I thought it would draw survivors away from the Choir's land. It drew them toward the lighthouse. And it drew the Choir, too.

*Rose says nothing for a long moment.*

ROSE
(quietly)
You kept the lamp lit.

ALDER
Every night.

ROSE
(a small nod)
That's something.

*Alder lowers his head, moved to tears. Rose crosses to him and, awkwardly, touches his sleeve.*

ROSE (CONT'D)
(whisper)
Mom says you leave some for whoever comes next.

*Alder looks at her, astonished. He covers her small hand with his.*

*A distant sound: a low, layered chord, rising from the sea. The lamp flickers.*

ALDER
(rising, urgent)
They are here.

*Rose runs for the stairs. Alder follows.*

---

### CS13 — "The Choice" (Mission 3.4, about 5 min)

**INT. LIGHTHOUSE — UPPER ROOM — NIGHT**

*A small round room with a camp bed. Tom stands by the window with a lantern. On the bed, Finn sleeps. Rose bursts in.*

ROSE
Dad.

*Tom turns. For a second he cannot speak. He crosses the room in three strides and kneels, holding her so tightly she squeaks.*

TOM
(into her hair)
Okay, okay, okay. You're here. You're here.

ROSE
(muffled)
You gave away your jacket.

TOM
(laughs, breaks, laughs again)
I did. It was a bad jacket anyway.

*He pulls back to look at her, wipes his face on his sleeve.*

TOM (CONT'D)
Rosie. You walked all this way?

ROSE
I had Biscuit. (A beat. If the dog is not with her:) I lost him. He's okay. He's very fast.

*Tom nods, gently, understanding.*

*From the window, a voice. Faint. Beautiful. Elena's, from the rocks far below.*

ELENA (V.O.)
(distant, singing the lullaby)
Little light, little light, hold the night...

*Rose and Tom rush to the window. Far below on the causeway, a single small figure stands on the rocks, a lantern at her feet, singing. Around her, a slow tide of pale figures moves across the sand: the Choir, drawn by her voice.*

TOM
(cracked)
Elena. No. She said she would meet us.

*Tom starts for the door.*

ALDER (O.S.)
(from the stairs)
Tom. If you go down there, they will take you too.

*Tom stops. He looks at Finn, asleep. He looks at Rose. He looks at the window.*

TOM
(quietly)
I can't leave her.

ALDER
You cannot leave your son.

*A terrible silence. The Choir's chord swells outside. The lamp begins to dim. Finn stirs in his sleep. The music box in Rose's hand begins to burn with amber light.*

*She looks at it. She looks at her father. She looks at her brother.*

*Rose understands. The Choir is not following Elena. They are following Finn. And the only thing that can lead them away is the box, and a voice that matches it.*

ROSE
(very quietly)
It's the song.

TOM
What?

ROSE
They want the song. The box. If I sing it, they'll follow me.

TOM
Rose. No.

*A beat. The lamp gutters. Rose looks at the cupboard in the corner of the room, where she could hide, as she has always hidden. She could stay quiet. She has always been good at staying quiet.*

*GAMEPLAY: CLIMAX_CHOICE. The player decides: walk to the stairs and go down to the rocks (SING), or crouch in the cupboard (HIDE). There is no on-screen prompt other than the two paths. Hold for as long as the player wants. The music is a single held note.*

---

### CS14A — "Home" (ending, SING, HEART >= 3, about 5 min)

**EXT. CAUSEWAY — NIGHT**

*Rose walks across the sand with the music box held in front of her like a lantern, humming. Behind her, Biscuit (or Marrow, if alive) keeps a careful distance, lighting her way. The Choir gathers around her, circle after circle, silent. She walks past Elena, who kneels on the rocks, her scarf wrapped round a wound at her side.*

ELENA
(whisper)
Rose.

ROSE
(not stopping, still humming)
I've got them, Mama.

*Elena begins to hum with her. The two voices fit together, and the Choir, hearing the finished song for the first time in three years, stops. One by one they close their mouths. One by one they sit down in the sand. They are quiet. They are not Hollow any more; they are tired people, resting.*

*The lighthouse lamp flares white. The beam sweeps the bay. The sea looks like silver.*

*The music box, in Rose's hands, plays its last three notes and falls silent. The amber glow fades. Rose looks at it. She does not cry.*

ROSE (CONT'D)
(whisper)
Thank you.

*She sets it gently in Elena's hands. Tom, Finn and Alder come running down the rocks. They hold each other. Finn, wide awake, laughs and reaches for Rose's face.*

**EXT. LIGHTHOUSE — DAWN**

*Morning. Gulls. The first birdsong in three years. The family sits on the steps of the lighthouse. Alder is among them. Marrow, if alive, leans against the wall, eating bread. Biscuit chews the wooden dog.*

ELENA
(to Rose)
You did that.

ROSE
(shrugging)
I was listening.

*Tom laughs. Elena kisses Rose's head. Far off, across the bay, a single bird sings.*

*Fade. Title: LOST. Beneath: "Found."*

---

### CS14B — "Quiet" (ending, SING, HEART <= 2, about 5 min)

**EXT. CAUSEWAY — NIGHT**

*Same opening as CS14A: Rose walks, humming, the Choir gathering. But the circle is incomplete. Some of the pale figures drift toward the lighthouse door. Rose hums louder. It is not enough.*

*Elena, on the rocks, sees what is happening. She stands, holding her side, and walks toward the Choir.*

ELENA
(to Rose, steady)
Keep walking.

ROSE
Mama, no.

ELENA
Rosie. Listen to me. Take Finn, take your father. Take the box.

ROSE
(crying)
No. I can't.

ELENA
(smiling, tears in her eyes)
Yes you can. You are the bravest thing in my life. Go.

*She turns her back, lifts her voice, and begins to sing. The Choir turns toward her, one by one. They surround her, gently, and the circle closes. She sings. She does not stop singing. The lighthouse beam passes over her once. Then the tide of pale figures moves out across the sand, taking her with them, her voice growing smaller and smaller until it is only a thread of sound.*

*Rose stands on the shore, the music box silent in her hands. The amber light is gone. Tom runs down the rocks and catches her as she begins to fall.*

**EXT. BOAT — DAWN**

*A small fishing boat on a calm sea. Tom rows. Finn sleeps in Rose's lap. Alder stands on the jetty behind them, one hand raised in farewell; the lamp turns above him.*

*Rose looks back at the shrinking lighthouse. She takes out the music box. It does not hum. She puts it in her coat, over her heart, and turns to face the water.*

ROSE
(quiet)
We'll come back for her.

TOM
(a long moment, then)
Okay.

*The boat moves toward the sunrise. Title: LOST.*

---

### CS14C — "Hollow" (ending, HIDE, about 5 min)

**INT. LIGHTHOUSE — UPPER ROOM — NIGHT**

*Rose is in the cupboard, knees to her chest, hands over her mouth. Through the crack in the door we see Tom looking for her. He finds the room empty. He sees the open window. He believes she has gone out.*

TOM
(calling, desperate, then silencing himself)
Rose! ...Rose.

*He goes. Rose does not move. She does not make a sound. Far below, Elena's song falters and stops. The Choir's chord swells. The lamp goes out. Mr. Alder's last words come up the stairs:*

ALDER (O.S.)
(calm)
I am sorry. I am so sorry.

*Then nothing.*

*Rose sits in the dark. The music box in her lap hums, then stops. The silence is enormous.*

**INT. LIGHTHOUSE — MORNING**

*Grey light. Rose climbs out of the cupboard. The room is empty. The bed is empty. The lamp is dark. She walks down the stairs, through empty rooms, past a table set for two, past Alder's coat on its hook. At the bottom, the door is open. Outside, Tom and Finn stand on the shore, alive, shaken. They turn and see her. Tom's face breaks. He runs. He holds her. She does not hold him back.*

TOM
(sobbing)
Where were you? Where were you?

ROSE
(flat)
I was quiet.

*Tom pulls back. Something in her voice makes him look at her more closely.*

*Over his shoulder, Rose sees Elena at the end of the beach, standing very still, her eyes closed, her mouth slightly open. She is humming one long, even note. It is the same note as the figure in Dad's jacket.*

*Rose does not move. She does not scream. She opens her own mouth, and, without meaning to, begins to hum the same note.*

*Hold. The sea. The silence. The note. Cut to black. Title: LOST.*

*(Direction note: the Hollow ending must be unsettling, never cruel to the player. It should feel like a consequence the game spent ten hours teaching, not a trick.)*

---

### CS15 — "Epilogue stinger" (after HOME or QUIET only, about 1 min)

**EXT. LIGHTHOUSE — LATER**

*HOME: A year later. A wooden sign on the lighthouse door reads HARBOR in Rose's careful handwriting. Children play on the sand. Elena, healed, hangs laundry. Finn takes his first steps toward Rose. Alder sits on a chair in the sun with Biscuit asleep on his feet. The lamp turns in daylight.*

*QUIET: Months later. The boat docks at a distant town. A radio on the quay is playing, faintly, the first four notes of the lullaby, a woman's voice. Rose stands very still. Tom looks at her. She looks at the radio. Cut to black.*

---

### CS16 — Post-credits (all endings, about 30 seconds, optional)

*Black. A radio crackle. A child's voice, small, far away.*

CHILD (V.O.)
(radio)
Hello? Rose? I heard you. I'm at the... I'm at the...

*(Only if H2 was chosen.) Static. A different voice, an older woman's, close to the microphone:*

VALE (V.O.)
(tape, gentle, clinical)
Hello, Rose. I have been waiting for you. You have such a lovely voice.

*Cut to black. No title.*

*(Sequel hook. Not required for the ending; remove if the studio prefers a closed story. If H2 was not chosen, play only the static.)*

---

## 7. Collectibles

Three categories, each with a short written text. Short enough to read in under 15 seconds. No collectible is required.

### A. Hearts and notes (Mom's trail)
Chalk hearts mark the route; each has a short note once Rose finds the third heart in a region. Examples:
- *"Rose, we'll wait at the school. Stay quiet. Love you."* (Pinewood)
- *"Dad's fixing the radio. He says you'd be bored. You wouldn't."* (Rust Flats)
- *"Don't go through the fields at night. I know you. Don't."* (Drowned Fields)
- *"I hear Biscuit is good company."* (Greenhouse, read only if Biscuit is with Rose; the game never explains how Mom knew)
- *"If you are reading this, I am so proud of you."* (Coast road)

### B. Dr. Vale's tapes (backstory, 6 total)
1. *"Project Lullaby, day one. The hospice children sleep better to the tone. Imogen Vale, recording."*
2. *"The tone seems to travel. I have asked Harbor to reduce power. They have not."*
3. *"Elena asks if the staff may stop listening. I told her it was perfectly safe."*
4. *"A child in Bed 4 is humming it back to me. It is not quite the same note. It is better."* (A hint that Finn's tone is the counter-tone.)
5. *"Things have changed. I walk through the wards and no one speaks. They only listen to me. I think they are waiting."*
6. *"If the child is found, bring him to the lamp. He is the last note."* (Found in Alder's drawer; Alder wept when he heard it.)

### C. Children's drawings (emotional collectibles, 8 total)
Found throughout the world, each a simple child's drawing with a caption, and each framed by the game as something Rose chooses to keep. They are never explained; they simply accumulate. A full set unlocks a final drawing in the epilogue (HOME ending only): a drawing by Rose herself of a lighthouse with five figures and a dog.

---

## 8. Ambient barks and radio lines

### Rose (very sparing; whispered; context-triggered)
- Hiding: *"Quiet, quiet, quiet."*
- Hollow nearby: *"Don't look at me."*
- Low battery: *"Please don't go out."*
- Finding a heart: *"Mama."*
- Finding a dead end: *"Okay. Another way."*
- Cold or rain: *"It's okay. It's okay."*
- After humming near Choir: *"They heard."*

### Biscuit (no words; performance cues)
- Soft huff = Hollow in range, no sight.
- Low growl = danger within 10 m.
- Tail-wag and nuzzle = safe to move.
- Whine = near a chalk heart or family scent.

### Marrow (if alive)
- *"Quiet feet, kid."*
- *"Left. Left. The other left."*
- *"That's a dead end. Trust me. I've died there."* (dark humor, never repeated twice in a row)

### Alder's looping radio (Act II ambient, plays in the distance)
*"To anyone who can hear this. If you are lost, if you are alone, come to the lighthouse on the coast road. Follow the light. Keep your voices low. You are not the only one. This message repeats."*

### The child's voice (only if H2 was chosen)
Heard faintly on Rose's radio after Rust Flats: *"I heard you, Rose. I'm coming."*

---

## 9. Integration notes for the build session

These are **suggestions** for how the writing maps onto the build. Nothing here requires code to be written by this session.

- **Mission IDs** (P.1, P.2, 1.1 to 1.5, 2.1 to 2.11, 3.1 to 3.5) and **cutscene IDs** (CS01 to CS16) are stable references. Please keep them in file names, scripts and data.
- **Flags** from section 4: `HEART` (0 to 4), `H1` to `H4`, `BISCUIT_WITH_ROSE`, `MARROW_ALIVE`, `HEARD_DAD_TAPE`, `READ_JOURNAL`, `CLIMAX_CHOICE`.
- **Cutscene count and effort:** CS01, CS09, CS10, CS12, CS13 and the three endings (CS14A/B/C) are the high-effort ones. CS02, CS03, CS04, CS05 and CS15 can be real-time in-engine with the existing Rose rig. CS16 is optional.
- **Rose model:** the semi-realistic Rose from the user's FBX needs, at minimum, a face rig for CS01, CS09, CS10, CS12 and CS14. Hands matter: she holds the music box in many shots.
- **Voice casting:** Rose should be performed by a child actor (about 8 to 10) with a quiet, plain delivery. Avoid "movie-kid" performance. Mom, Dad, Alder and Marrow are standard adult roles. Dr. Vale is recorded voice only.
- **Sound design is the story.** The Hush, the Hollow and the Choir are all communicated through sound. Please budget audio time accordingly: the layered Choir chord, Elena's lullaby, the music box's three notes, and long stretches of near-silence.
- **The lullaby.** Original, public-domain-safe lyrics (not a real nursery rhyme). Only a fragment is ever sung: *"Little light, little light, hold the night..."* It needs a composer to finish. The melody must work as a **hum**, as a **music box**, and as a **layered choral chord** (same tune, three textures).
- **Open writing questions for the user:**
  1. Is the "Finn is adopted and Rose does not know" detail acceptable? It is only implied in the journal and CS12; it can be cut without breaking anything.
  2. Is the sequel hook in CS16 wanted?
  3. Should the Hollow ending be playable in the base game, or gated behind a second playthrough?
  4. Does the user want Marrow to be a permanent companion in a future DLC chapter?
- **What this document does not include:** no code, no models, no textures, no audio files, no animation data.

*End of handoff.*
