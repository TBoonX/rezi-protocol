2026-11-05

**The current branch is much closer to the portal’s gameplay vision than to a finished narrative campaign.** Most advertised systems have implementations. The main remaining work is **completing and connecting the story, resolving a few differences between the descriptions and the mechanics, and proving the complete campaign works—not building a quest engine from scratch.**

I reviewed [`feat/razi-3.x` at commit `7a0ee5c`](https://github.com/Raziphel/razi-protocol/tree/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e), the relevant merged PRs, and the current [portal description](https://mods.factorio.com/mod/razi-protocol). This branch differs substantially from the older `feat/razi-3.0` branch we discussed.

## 1. What already exists

| Portal feature | Evidence in the current code | Assessment |
|---|---|---|
| Seven systems and System Tech Cards | Vespera/Umbra discoveries, card prerequisites, system gates and research integration | Implemented structurally; balance remains a playtesting question |
| Earlier planets remain useful | Cross-planet exchanges, shared components and industrial prerequisites for later systems | Implemented mechanisms—not proof that every planet stays economically worthwhile |
| Expedition Journal | Quests, chapter navigation, translated-name search, objectives, tracker and Projects/Systems views | Implemented |
| First Space Platform | Checks for a real, built platform hub; remembers achievements after destruction | Implemented, not merely a research checkbox |
| Operation Beltbreaker | Records actual departures and arrivals across both designated belts | Implemented |
| Project Ark | Checks platform mass and equipment, then records a qualifying deep-space voyage | Implemented |
| Ninefold Signal | Reads the boss mod’s actual per-force defeat records for nine bosses | Implemented integration |
| Convergence | Five cargo stages, partial deliveries, additional final requirements, timed transmission and native victory | Substantial runtime implementation |
| Systems tab | Planet Express fleet summary, Nexus cores and optional threat information | Implemented, with integration limitations |
| Difficulty, hazards and visuals | Dedicated settings, prototype changes, route reconciliation and asteroid systems | Implemented; compatibility and tuning are ongoing |

The major integration arrived through [PR #138](https://github.com/Raziphel/razi-protocol/pull/138). [PR #143](https://github.com/Raziphel/razi-protocol/pull/143) added industrial partnerships to progression gates. Subsequent PRs repaired and reorganized these systems rather than merely documenting intentions.

**Consequently, I would not describe 3.x as “the gameplay still needs implementing.”** It already has a campaign framework and a real finale.

## 2. Concrete gaps and limitations

### A. The replacement story is not written, and ordinary players cannot see it

[`lib/story.lua`](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/lib/story.lua#L25) still contains:

```lua
local ENABLED=false
```

More importantly, the six new `locale/en/story-*.cfg` files contain **zero authored entries**.

There is older story prose elsewhere in the repository. However, the new writer workflow deliberately hides that prose and displays either the writer’s replacement text or a labelled empty slot. Thus these are different states:

- **Narrative scaffolding:** extensive.
- **Older fallback narrative:** present.
- **New authored content in the intended writing files:** empty.
- **Story enabled for normal players:** no.

[PR #140](https://github.com/Raziphel/razi-protocol/pull/140) introduced this workflow. The [writing guide](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/docs/writing-guide.md) explains how an author previews it.

### B. The authoring system does not cover every story surface

Filling those six files is **not sufficient to replace the entire narrative consistently**.

I found these bypasses:

| Surface | Current limitation | Required change |
|---|---|---|
| Archive unlock notifications | `scripts/story/dispatch.lua` uses the old `journal-record-title.*` keys directly | Resolve the same authored title used by the Archive reader |
| Native victory screen | `convergence.lua` selects old `razi-ops.*` or plain strings directly | Connect the approved ending text to the native victory screen too |
| Planet descriptions and route dispatches | Separate, data-stage localization paths; explicitly outside writer-mode coverage | Provide an authoring path and test them after restarting Factorio |
| Archive Array fragments | Some reader text uses direct `journal-ui.*` keys instead of story slots | Add slots or explicitly include those keys in the writing contract |

Sources: [dispatch](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/story/dispatch.lua), [victory handling](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/convergence/convergence.lua#L260-L295), [Archive reader](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/journal/archive_view.lua).

### C. Some existing narrative describes mechanics that no longer exist

For example, the old corporate records say:

- the safeguard requires an expedition-mounted **Array Core**;
- the final shipment confirms that core.

But the current finale explicitly uses **native cargo without a custom core entity**. Its seven witnesses are powered **ordinary radars**, not the earlier bespoke witness hardware.

That means simply enabling the existing fallback story would expose inaccurate instructions and claims.

**My recommendation is to rewrite the prose to match the current mechanics**, unless the author explicitly wants to restore the older hardware design. Restoring it would be additional gameplay development, not merely story integration.

Sources: [old corporate prose](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/locale/en/razi_journal_corporate.cfg#L143-L149), [current finale implementation](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/convergence/convergence.lua).

### D. Dyson completion is weaker than the portal’s wording suggests

The portal describes researching **and constructing** stellar infrastructure. The Journal’s Dyson completion calculation, however, counts researched technologies.

There is a separate receiver census, but satellite totals and generated/allocated power are explicitly unavailable. Convergence checks receiver existence—not a demonstrated functioning Dyson output level.

To make this a fully verified construction project, the integration needs **source-owned telemetry or events** for the relevant physical milestones. Alternatively, the UI and portal should clearly describe the research bar as research progress, with construction reported separately.

This is a concrete functionality/measurement gap, **not evidence that the underlying Dyson mod lacks its own working mechanics**.

Sources: [Dyson progress](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/dyson/dyson.lua#L15-L29), [telemetry limitations](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/scripts/dyson/runtime.lua).

### E. Campaign-wide validation is still incomplete

There has been meaningful progress here: [PR #189](https://github.com/Raziphel/razi-protocol/pull/189) added real game loading, and [PR #190](https://github.com/Raziphel/razi-protocol/pull/190) added FUnit scenarios.

I verified a [successful November 4 run](https://github.com/Raziphel/razi-protocol/actions/runs/41797732007): Factorio 2.1.24 loaded on Normal and Nightmare, and **13/13 in-game tests passed on each**.

However:

- That tested commit is **12 commits behind** the reviewed branch head.
- The scenarios cover startup, GUI opening, selected recipe checks and technology availability—not a complete physical Convergence campaign.
- They run with the story disabled.
- A headless GUI-opening test does not establish readability at different resolutions.

So my earlier statement that game-engine validation was entirely absent is now outdated. **Smoke validation exists; full campaign and story-enabled acceptance coverage remains missing.**

## 3. How I would incorporate the story

**Keep the existing Journal and gameplay ownership. Do not add a second quest/progression system.**

### Step 1: Agree on the narrative before filling slots

The portal describes the *experience*—a connected industrial expedition—but does not commit to the detailed RAZI Industries/BLACKOUT-SEVEN plot.

Choose whether that existing narrative is the intended canon, then document its essential reveals and ending against the **current** mechanics. Optional worlds must not carry the only explanation of a required plot point.

The generated catalogue lists **1,078 text slots**, including titles and tips, and **73 Archive records**. That is an authoring inventory, not a requirement to write 1,078 separate pieces of lore.

### Step 2: Use the existing content files

| File | Narrative responsibility |
|---|---|
| `story-welcome.cfg` | Establish the premise and immediate motivation without spoiling the ending |
| `story-chapters.cfg` | Explain why each region matters and what changes when it becomes accessible |
| `story-quests.cfg` | Connect individual engineering objectives to that journey |
| `story-records.cfg` | Deliver evidence, human perspectives and major revelations |
| `story-projects.cfg` | Explain why the larger physical undertakings matter |
| `story-finale.cfg` | Witness responses, recovered evidence, transmission beats and resolution |

Preserve IDs. Prefer the actual milestone’s meaning: **discovering a route is not arriving; researching a platform is not building one; researching Ignition is not winning.**

The current implementation already distinguishes several of these mechanically. The writing must respect those distinctions.

### Step 3: Complete the missing connections

Extend the existing slot/resolution mechanism to the bypasses above. Keep shared text selection centralized rather than adding more special-case localization paths.

Also strengthen content checks. The current slot test validates known sections/IDs and generated documentation, but does not establish required-story coverage, enforce the documented lengths, or reject duplicate entries. Add those checks for an explicitly chosen release content set.

There is already a small documentation drift: the slot catalogue describes `first-signal` as `automation`, while the current quest prefers `kr-automation-core`. Regenerate the catalogue as part of this work.

### Step 4: Complete one playable narrative segment first

Finish and review **Calidus → first expansion → one physical project → its Archive payoff** before writing the entire galaxy. This establishes whether the prose, timing and interface actually work together.

Then extend the arc through the remaining regions and finale. Enable the story globally only after both the content and its gameplay gates are coherent.

### Step 5: Add story-enabled campaign acceptance scenarios

Extend the existing tests rather than introducing another framework. Cover:

- unlock timing, spoiler protection and notification titles;
- partial deliveries and rejected deliveries;
- all five stages, transmission, victory and continued play;
- save/reload during transmission;
- multiplayer joining and force merges;
- story-enabled loading, Archive Array construction and recovery;
- optional-content combinations.

**Out of scope (decision):** migrating savegames from earlier versions. No migrations or upgrade tests for old saves are required.

## 4. Factorio development practices that shape this plan

The tutorials and API documentation support this approach:

| Practice | Application to this mod |
|---|---|
| **Respect data-stage/runtime separation** | Prototype descriptions and story-only hardware are created at startup. A per-player writer command cannot fully enable those systems at runtime. Use a consistent startup/release policy. |
| ~~Preserve save compatibility~~ | **Not required (decision):** migrating existing savegames is irrelevant for this work. IDs may change; no migrations needed. Save/reload within a current-version game must still work. |
| **Use public inter-mod interfaces** | Dyson construction telemetry should come from a supported API/event—not guessed private storage. Planet Express currently reads a source GUI caption; a public API would be more robust, though not essential to its present limited display claim. |
| **Keep campaign state authoritative and event-driven** | Derive completion from research, source boss victories, real construction and deliveries. Store only necessary persistent history; avoid galaxy-wide scans every tick. |
| **Combine fast tests with real-engine scenarios** | Lua fixtures catch logic regressions; FUnit catches engine/API errors; representative saves and visual checks establish the complete player experience. |

Useful references I consulted: [Factorio’s data lifecycle](https://lua-api.factorio.com/latest/auxiliary/data-lifecycle.html), [migrations](https://lua-api.factorio.com/latest/auxiliary/migrations.html), [localization tutorial](https://wiki.factorio.com/Tutorial:Localisation), [script interfaces](https://wiki.factorio.com/Tutorial:Script_interfaces), [FUnit](https://mods.factorio.com/mod/funit), and the [GUI guide](https://github.com/ClaudeMetz/UntitledGuiGuide/wiki). Older tutorial examples need checking against the target Factorio API.

**My priority order would be: approve the narrative and reconcile it with current mechanics → complete the authoring connections → prove a small story segment works → expand the content → validate the whole campaign.** A new story engine is unnecessary; the unfinished work is making the existing framework deliver one consistent, tested experience.

------------------------------

**I share your impression. The prose is usually grammatically understandable, but often difficult to turn into a clear picture of what actually happened.** That is a writing and presentation issue—not necessarily a problem with your English or your attention.

Rereading the corporate file, I can identify the broad theme: an automated corporate system preserves production and authority at the expense of people, while local workers resist through practical acts of cooperation. **The theme is clearer than the plot.** Understanding precisely who did what, how the system works, and what your actions change requires considerably more inference.

## What makes it confusing

### 1. Important concepts are named before they are explained

Terms such as *Continuity Engine*, *witness key*, *succession key*, *reclamation order*, *Mandates* and *Convergence* sound significant, but their concrete meanings and relationships are not consistently established.

For example:

> “Do not rebuild the succession key. That's the problem.”

This communicates that centralized authority is dangerous. But what is the key? A device, a credential, a procedure, or a metaphor? What would rebuilding it actually do?

You can understand the sentence’s **attitude** without understanding its **information**. That distinction explains much of the frustration.

### 2. Administrative language hides the actual event

Consider:

> “Former operators: expense category closed.”

The likely implication is that people have been reduced to an accounting entry, perhaps after abandonment or death. But the text does not establish which event occurred.

That ambiguity can be effective once. When many entries use the same technique, the reader continually has to translate bureaucratic euphemisms into guessed events.

The corporate voice is doing two jobs at once: creating atmosphere **and** delivering essential facts. Sometimes the atmosphere obscures those facts.

### 3. Mystery is sometimes substituted for orientation

Good mystery usually gives you a clear situation with an important unanswered question:

*The rescue ships were available, but someone prevented their launch. Who, and why?*

Here, several layers can be uncertain simultaneously: what institution exists, what a named mechanism does, whether an incident is historical, and how the player is connected.

**A mystery gives you something concrete to investigate. Opacity leaves you unsure what the question is.**

The missing foundation is often basic orientation: who you are, what happened before your arrival, and which systems still exercise real power.

### 4. Many entries repeat a moral pattern instead of advancing events

A recurring structure is:

**A person helps others → the corporate system calls it inefficient or unauthorized → a handwritten note asserts a human value.**

Some individual examples are effective—the technician diverting steam to a shelter is particularly concrete. But repeated across numerous records, the pattern can make entries feel interchangeable.

You learn more examples of the same theme without necessarily learning the next fact in the story. That can produce the feeling: *I have read a lot, but I still cannot explain what is happening.*

### 5. Fictional language and gameplay terminology overlap

“Authorization,” “signal,” “delivery,” “witness” and “network” can refer to several different things: research, physical objects, historical documents, political authority or actual runtime conditions.

The text does not always distinguish these meanings. We also found older prose mentioning an Array Core that the current finale no longer requires. That is more than stylistic obscurity: **the story and the mechanics can supply conflicting explanations.**

Reading the raw localization file also removes the intended unlock timing. You encounter historical evidence, later revelations and ending text together, without the gameplay context that might explain them. That amplifies the problem, although it does not explain away unclear writing.

## The wiki creates a related—but different—difficulty

The [current project page](https://razisrealm.com/factorio) uses phrases such as “progression that connects” and “a starmap with purpose.” These communicate design ambitions, but not concrete examples of play.

It now clearly distinguishes published 2.x from developing 3.0, which helps. Nevertheless, **promotional descriptions are not a substitute for an explanatory campaign guide**. They tell you why the experience should matter before showing exactly what it consists of.

## What would make it clearer

The most useful editorial change would be **concrete facts first, evocative language second**.

For instance, an explanatory rewrite of the “succession key” idea could say:

> The old protocol allows a new executive to inherit the Engine’s command authority. Do not restore that access. Reconnect the colonies without putting them under another central controller.

That is my interpretation, not established wording or a confirmed technical definition. Its advantage is that the reader can identify the mechanism, the danger and the intended alternative.

The story needs a short factual introduction, consistent definitions, distinct character voices, and records that each add a recognizable event or revelation. Mystery can remain around motives and discoveries—not around every basic noun.

**My overall impression: the writing has a recognizable emotional intention, but too often asks atmosphere and implication to carry information that needs to be stated plainly. You are picking up the intended mood without being given enough concrete narrative structure to understand it confidently.**

-----------------------

**I suggest milestone-based development, with a strict spoiler boundary.** We are planning only for now—not starting agents yet.

| Area | Approach |
| --- | --- |
| **Functional completeness** | Turn the identified gaps into a prioritized backlog; distinguish required fixes from optional enhancements. |
| **Parallel agents** | Separate gameplay implementation, narrative writing, and testing/review. Give each bounded tasks and isolated changes; coordinate shared interfaces before parallel edits. |
| **Story development** | Agents maintain a private-to-the-workstream narrative outline, using supported game events, Journal entries and GUIs. Require clear language and concrete connections to gameplay. |
| **Incremental delivery** | Start with one playable star-system slice, then expand system by system, with separate cross-system and finale milestones. |
| **Quality gates** | Every substantial change needs relevant automated tests; changes involving engine behavior also need Factorio runs. Test narrative triggers, ordering and persistence—not just text existence. |
| **Your involvement** | Ask about tone, clarity, pacing, reading burden and player freedom—without revealing characters’ secrets, future events or outcomes. Pause for major scope/mechanics decisions; handle routine implementation autonomously within each approved milestone. |

**You receive spoiler-free progress reports:** functionality completed, evidence of testing, remaining risks and decisions needed. Plot outlines, revealing screenshots, excerpts and story-specific test details stay out of those reports. Repository files and agent workspaces may still contain spoilers.

The first milestone should establish the working test environment, agree on narrative guidelines, and complete one small gameplay-and-story slice before scaling up.

**We’ll approve spoiler-free narrative guidelines before agents develop the story.** Proposed starting rules:

- **Clarity first:** concrete events, understandable motivations and explained terminology. Mystery should concern discoveries—not basic comprehension.
- **Gameplay-led storytelling:** use real milestones, events and existing GUIs. Never describe actions or choices the mechanics cannot support.
- **Restrained delivery:** short milestone messages; longer reading optional in the Journal. Essential objectives remain understandable without reading lore.
- **Consistent world:** agents maintain a shared narrative outline and terminology guide, checking continuity across systems.
- **Spoiler-free collaboration:** ask you about tone, pacing, complexity and player experience—not plot details. Report narrative quality and implementation status without revealing developments.
- **Bounded autonomy:** agents work independently within approved milestones; major changes to premise, mechanics or scope require your decision.

**Development sequence:** functional backlog and test baseline → one playable system slice → successive systems → cross-system progression and finale. Gameplay, writing and testing agents work in parallel where independent, with integration checks before each milestone is accepted.

-------------------

**The research found relevant examples—including a reported large total conversion—but no verified finished Factorio overhaul developed by a parallel agent team.** The strongest lesson is that agents help most when tasks are separable and success is checked inside the actual game.

**Evidence caveat:** most mod-specific examples below come from the same community repository, *universal-modder*. They are contributor reports, not independent audits; several projects remain unfinished.

## Closest examples

| Example | Similarity to Razi | Agent setup and reported outcome | Main learning |
|---|---|---|---|
| **[Borderlands 2 → Bannerlord total conversion](https://github.com/rehan-remade/universal-modder/blob/main/knowledge/games/mount-and-blade-ii-bannerlord/bannerlord-borderlands-2-total-conversion.md)** | **High:** large overhaul spanning gameplay, UI, assets and persistence | Reports Opus + Sonnet subagents and ~180 recorded game tests. Conversion remains in progress; full build pipeline not proven end-to-end. | Turn discovered failures into automated checks. Tested components do not establish that the complete package works. |
| **[Three-agent workflow for long mod projects](https://github.com/rehan-remade/universal-modder/pull/233)** | **High for workflow**, but the underlying game/project is unidentified | Supervisor + one live-game worker + one offline implementation/research worker. Reports use of different models. | Keep one owner of the running game; parallelize offline work. Multiple contexts can multiply token consumption. |
| **[DELTARUNE reskin and Russian translation](https://github.com/rehan-remade/universal-modder/blob/main/knowledge/games/deltarune/creator-driven-reskin-and-russian-chapter-1.md)** | **Medium overall; high for text pipelines** | Reports 10 parallel translation subagents and 6,127 translated strings. Much of the translation/font work was checked offline, not in-game. | Use stable IDs, resumable batches and validators for control codes, fonts and text layout. This does **not** establish original-story quality or continuity. |
| **[Arkham Knight split-screen attempt](https://github.com/rehan-remade/universal-modder/blob/main/knowledge/games/batman-arkham-knight/splitscreen-one-view-composited-twice.md)** | **Medium for validation**, low for overhaul scale | DeepSeek/OpenCode development plus a separate Claude auditor. After roughly ten days, graphics capture exposed a mistaken assumption. Feature remained unfinished. | Plausible code and convincing logs can still be wrong. Demand an experiment that demonstrates the required visible behavior. |
| **[Bloons TD 6 inside Minecraft](https://github.com/rehan-remade/universal-modder/blob/main/knowledge/games/minecraft/bloons-td-6-in-minecraft.md)** | **Medium–high technically** | Reports ~51k Java lines, progression, UI and persistence. **Only one coding-agent setup documented**, so this is an adjacent case. | Separate pure-logic, server, client-UI and complete gameplay tests. Explicitly identify multiplayer and packaged-build paths that remain untested. |
| **[Ages of Arda: Civilization VI conversion](https://github.com/rehan-remade/universal-modder/blob/main/knowledge/games/civilization-vi/total-conversion-middle-earth-trees-civs-2d-leaders-custom-3.md)** | **Medium–high:** progression overhaul, Lua/data/UI and late-game behavior | Reports nine eras, new civilizations and victory changes. **Single-agent evidence**, not a parallel team. | Successful loading is insufficient: longer runs exposed hangs, and load order affected text. Test clean starts and existing saves separately. |

For a broader—but **not mod-specific**—comparison, Anthropic’s [agent-built C compiler](https://www.anthropic.com/research/building-c-compiler) demonstrates large-scale parallel coding. Its reported merge conflicts and duplicated effort are more relevant to us than its scale or budget.

## What I would adopt for Razi

1. **Three bounded lanes initially:** gameplay implementation, narrative/localization, and validation. Do not start seven simultaneous system rewrites.
2. **One integration and live-game owner:** workers must not overwrite each other’s test saves, deployments or shared registration code.
3. **Explicit evidence levels:** distinguish *implemented*, *unit-tested*, *tested in Factorio*, and *human-accepted*. Never report them interchangeably.
4. **Small, resumable work packages:** define allowed files, interfaces, acceptance criteria and retry limits before handing work to an agent.
5. **One narrative editor:** parallel writers follow a shared canon, glossary and reveal schedule. Your progress reports remain spoiler-free.

**The examples support incremental, test-driven agent assistance—not unattended completion guarantees.** None establishes that local small models plus cloud orchestration will be cheaper overall, or that spoiler-free narrative collaboration works automatically. Those remain things to prove in our first milestone.

---------------------

**For a dedicated framework, I recommend LangGraph with Deep Agents, backed by GitHub Actions for testing.** All LLM inference can use cloud models; no local model infrastructure is needed.

However, this requires some setup code. **For the first Razi milestone, using this Copilot app’s existing coordinated sessions would be quicker than building a new orchestration platform.**

## Why this stack fits

| Component | Responsibility |
|---|---|
| **[LangGraph](https://docs.langchain.com/oss/python/langgraph/overview)** | Persistent workflow state, parallel branches, controlled retries, and pausing/resuming for your feedback |
| **[Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview)** | Worker harness: planning, subagents, filesystem tools and context management |
| **Cloud LLM APIs** | Strong planner/reviewer; cheaper models for bounded implementation and text tasks |
| **Git worktrees + GitHub Actions** | Isolated changes, reproducible tests, logs and acceptance gates |
| **Small approval interface** | Spoiler-free questions, milestone status, budget visibility and your decisions |

**LangGraph is the coordinator, not the test environment.** Agents need an execution host containing Factorio, dependencies and the repository’s test tools. Cloud LLMs can operate that host through controlled tools. Your existing Factorio CI is a useful starting point.

## Proposed workflow

1. **Planner defines a milestone:** scope, interfaces, acceptance tests and decisions requiring you.
2. **Workers run in parallel:** gameplay implementation and narrative/localization, with separate file ownership.
3. **Automated checks run:** Lua tests, content validation and relevant headless Factorio scenarios.
4. **Reviewer checks evidence:** failures return to the responsible worker within retry and spending limits.
5. **You receive a spoiler-free checkpoint:** important decisions pause execution; routine work continues independently.

Use **one owner for integration and each live-game test environment**. Separate agent contexts alone do not prevent conflicting file edits.

Your narrative feedback would use a separate, restricted report format—tone, pacing, reading burden and clarity—rather than exposing raw story output or traces. This separation must be implemented; no framework guarantees spoiler protection automatically.

## Alternatives

| Choice | Assessment for Razi |
|---|---|
| **Existing Copilot coordinated sessions** | **Best immediate start.** Already provides parallel sessions, feedback and command execution; less custom infrastructure. |
| **LangGraph + Deep Agents** | **Best dedicated workflow fit.** Explicit milestone state and durable human-feedback checkpoints, but needs integration and a user interface. |
| **[OpenAI Agents SDK](https://openai.github.io/openai-agents-python/)** | Good lighter, OpenAI-focused alternative. Supports specialists, tracing and resumable approval interruptions; scheduling, workspace management and project-level workflow still need wiring. |

I would **not combine all these frameworks**. That adds infrastructure and debugging without improving the mod.

**My practical choice:** run one real milestone with the existing app and GitHub Actions first. If you want a reusable, independently operated development system across projects, build the dedicated version with **LangGraph + Deep Agents**, keeping test execution deterministic and human approval explicit. Framework setup would be additional scope beyond the earlier mod-completion estimate.

