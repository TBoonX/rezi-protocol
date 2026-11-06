# Razi 3.x — multi-agent coding practices

**Audience:** GitHub Copilot (and other coding agents) working on `feat/razi-3.x`.  
**Scope:** Process and quality gates only. **No plot spoilers** in reports to the human.  
**Companion briefs:** `Razi-protocol-3_situation.md`, `Razi-protocol-3_story+modlist.md`.  
**Evidence base:** project situation/story briefs + learnings from the `ai_knowledge` docs (orchestration, memory, critic evidence, harness, equal compute).

---

## Situation (one line)

The campaign machinery largely exists. Agent work is: **reconcile narrative with current mechanics → fill/connect authoring surfaces → prove one playable story segment → expand → story-enabled campaign acceptance.** Do **not** build a second quest/progression engine.

Prefer **existing Copilot coordinated sessions + this repo’s GitHub Actions / FUnit** for the first milestone. A dedicated LangGraph platform is optional later, not a prerequisite.

---

## Do first (before scaling agents)

### 1. Contract before agents

Every milestone needs a written brief before parallel work starts:

| Field | Required |
| --- | --- |
| Goal | One coherent outcome for this slice |
| Non-goals | Explicit out-of-scope (no new quest engine, no restoring removed hardware unless decided) |
| Allowed files / ownership | Disjoint paths per lane |
| Interfaces | Shared APIs, locale keys, migration rules |
| Success criteria | Numbered, checkable |
| Stop condition | `BLOCKED:` when inputs conflict; escalate mechanics/scope decisions |
| Spoiler boundary | What may appear in human-facing reports |

Agree **spoiler-free narrative guidelines** before writers fill story slots.

### 2. Mechanics win over prose

**Precedence (highest first):** runtime / Factorio evidence → current code & tests → portal description → old locale / fallback prose.

- Rewrite story to match **current** Convergence (native cargo, ordinary radars as witnesses, etc.).
- Do **not** reintroduce removed hardware (e.g. Array Core) from old locale unless the human explicitly restores that design.
- If portal, old prose, and runtime disagree → **stop and escalate**. Do not invent telemetry or entities.

### 3. Do not rebuild the quest engine

Keep Journal, quests, projects, systems, Convergence ownership. Deliver:

1. Authored content in the intended `story-*.cfg` slots  
2. Connections for bypass surfaces (notifications, victory text, planet/route copy, Archive fragments)  
3. Campaign / story-enabled acceptance proof  

### 4. Three lanes, one integration owner

| Lane | Responsibility |
| --- | --- |
| Gameplay | Lua/runtime, gates, integrations, migrations |
| Narrative / locale | Story slots, glossary, continuity (within canon outline) |
| Validation | Lua tests, content validators, FUnit / Factorio scenarios |

- At most **two** worker lanes in parallel on **disjoint** file sets.
- **One** owner of live Factorio runs, test saves, deployments, and shared registration code.
- Do not start seven simultaneous system rewrites.

### 5. One playable slice before the galaxy

Order:

1. Functional backlog + test baseline  
2. **One** playable system slice (e.g. first system → expansion → one physical project → Archive payoff)  
3. Successive systems  
4. Cross-system progression and finale  

Enable story globally for normal players only after the first slice’s content **and** gates are coherent.

---

## Every milestone (gates)

### Evidence ladder — never collapse levels

Label every status claim with exactly one level:

1. **Implemented** — code/locale present  
2. **Unit / Lua-tested** — fixtures / validators  
3. **Factorio-tested** — FUnit / headless / scenario / save path  
4. **Human-accepted** — spoiler-free checkpoint passed  

Slot existence ≠ readable experience ≠ campaign win. Never report them interchangeably.

### Mechanical gates for story I/O

Prefer validators over LLM self-review:

- Required slots filled for the release content set  
- Documented length bounds; no duplicate entries  
- IDs match the slot catalogue (regenerate catalogue when quest prefs drift)  
- Bypass surfaces resolve the **same** authored titles as the Archive reader  
- Prose claims ⊆ **tracked** mechanics (e.g. research progress ≠ constructed infrastructure unless telemetry exists)

### Objective / context / lore layers

| Layer | Purpose |
| --- | --- |
| Objective | Concrete action; observable completion |
| Context | Why it matters now (short) |
| Optional narrative | Journal / records — deeper evidence |

Mystery may surround discoveries and motives — **not** basic terminology or what the player can do next. Unexplained terms must not obscure the task.

### Trigger contracts with recovery

For each significant beat define:

**Eligibility → triggering evidence → persistent completion → presentation → recovery**

Cover: prior construction, destruction/rebuild, multiplayer / other force, missing optional mod, save/reload. A missing dependency must not silently skip a vital explanation or create an unwinnable objective.

### Procedures in the milestone brief — not a fat always-loaded file

- Keep this file and `AGENTS.md` short and stable.  
- Put **task-specific** steps in the milestone brief (≤ ~8 steps per role).  
- Maintain a shared **glossary + reveal schedule** as versioned artifacts with provenance — not an ever-growing mega-prompt.  
- One narrative editor / canon owner; parallel writers follow that outline.

### Critic blocks only on criteria + evidence

- Reviewer judges numbered success criteria with mechanical or quote-grounded evidence.  
- Failed checks return to the responsible worker within retry and spend limits.  
- Hitting a budget/iteration **cap** = `not_converged` / not shipped — never silent approval.  
- Human checkpoint: tone, clarity, pacing, reading burden, player freedom — **not** plot reveals.

### Equal compute before claiming multi-agent benefit

- Parallel lanes cost more tokens. Only claim a multi-agent win at comparable budgets on the same slice.  
- Report **cost per accepted milestone**, not only tokens spent on attempts.

### Harness enforces; prompts advise

- CI, FUnit, content checks, git worktrees, and tool allowlists enforce safety and quality.  
- Text “do not” lines are **not** a security control.  
- No shared writable folder as a covert coordination channel between agents.

### Reference modpack + optional-content matrix

- One **reference** mod configuration for development and acceptance.  
- Essential story understanding must work **without** optional worlds; optional content may enrich.  
- Document supported variations. Fix documentation drift (e.g. required vs optional dependencies in README vs `info.json`).  
- Successful load ≠ balance, narrative integrity, or reachable progression.

### BLOCKED when inputs conflict

If the task cannot be completed honestly with given inputs and tools, reply with:

```text
BLOCKED: <concrete reason>
```

and stop. Escalate: mechanics vs story conflicts, new hardware, scope changes, spoiler-policy changes.

---

## Avoid

| Avoid | Do instead |
| --- | --- |
| Seven parallel system rewrites | System-by-system after the first slice |
| Agent self-grade as acceptance | Human spoiler-free checkpoint + engine scenarios |
| Auto-retire “stale” lore from one signal | Two-step: flag suspected conflict → human/editor confirms |
| Spoiler or security rules only in prose | Filters and tool scopes in code; separate writer workspace from human progress channel |
| Copying Story Missions’ scenario architecture | Reuse Razi’s existing milestones as narrative anchors |
| Forcing drama that breaks the factory game | Major timers / forced losses / irreversible restrictions need explicit human approval |
| Collapsing “implemented” and “playtested” | Use the evidence ladder |

---

## Agent topology

| Role | Responsibility |
| --- | --- |
| **Planner / integrator** | Milestone brief, ownership map, interfaces, spoiler-free status, budgets, pause on premise/mechanics decisions |
| **Worker (gameplay)** | Runtime/Lua within allowed files; no narrative canon ownership |
| **Worker (narrative)** | Story slots / locale within canon; no inventing untracked mechanics |
| **Critic / validator** | Independent context; criteria + evidence only; never approve on cap |

Workers: free-text plans with numbered subgoals; **procedures over personas**. Fresh context per task when possible.

---

## Human checkpoint (spoiler-free)

Ask / report only:

- Tone, clarity, pacing, reading burden  
- Player freedom vs forced sequence  
- Comprehension of **what to do next** (no plot spoilers)  
- Evidence ladder status and remaining risks  
- Decisions needed (scope, mechanics, dependency matrix)

Do **not** put in human progress reports: plot outlines, revealing excerpts, spoiler screenshots, or story-specific secret test details. Repository files may still contain spoilers.

---

## Minimum milestone checklist

Copy into each milestone brief; tick before calling the milestone accepted.

1. [ ] **Contract** — goal, non-goals, files, criteria, stop, spoiler rules written  
2. [ ] **Mechanics match** — no prose claim without a tracked runtime fact  
3. [ ] **Lane isolation** — disjoint paths; one live-game owner named  
4. [ ] **Mechanical tests** — Lua/content validators green on changed surfaces  
5. [ ] **Factorio evidence** — relevant FUnit/scenario or save path exercised  
6. [ ] **Human checkpoint** — spoiler-free comprehension / freedom / pacing  
7. [ ] **Cost note** — calls/tokens (or time) for this accepted slice recorded  

---

## Narrative acceptance package (per system / cross-system milestone)

| Area | Acceptance evidence |
| --- | --- |
| Progression | Required tech/recipes/resources/transport reachable from the previous milestone |
| Story | Text matches mechanics; required context available without optional worlds or future reveals |
| Triggers | Correct timing; no premature reveals; no duplicate rewards/messages |
| Recovery | Save/reload, destroy/rebuild, prior completion, multiplayer cases covered where relevant |
| Presentation | Clear objectives; readable GUI; replayable context; valid localization |
| Experience | Short playtest: comprehension, pacing, worthwhile gameplay change |

Two test tracks: **prepared fixtures** (fast regression) and **continuous playthrough saves** (accumulated pacing/state). Fixtures alone can supply items ordinary progression cannot.

---

## Writing rules (spoiler-safe process)

- **Clarity first:** concrete events, understandable motivations, explained terminology.  
- **Gameplay-led:** use real milestones, events, existing GUIs. Never describe actions the mechanics cannot support.  
- **Restrained delivery:** short milestone messages; longer reading optional in the Journal. Essential objectives understandable without lore.  
- **Consistent world:** shared outline + glossary; continuity checks across systems.  
- **Preserve stable IDs;** use migrations for necessary changes. Prefer milestone meaning: discovering a route ≠ arriving; researching a platform ≠ building one; researching Ignition ≠ winning.

Authoring files (when filling content): `story-welcome.cfg`, `story-chapters.cfg`, `story-quests.cfg`, `story-records.cfg`, `story-projects.cfg`, `story-finale.cfg` — preserve IDs; extend slot resolution to bypass surfaces rather than adding more one-off localization paths.

---

## Factorio constraints agents must respect

- Data-stage vs runtime separation (writer commands cannot fully enable data-stage systems at runtime).  
- Save compatibility and migrations.  
- Public inter-mod interfaces for telemetry (no guessing private storage).  
- Campaign state authoritative and event-driven; avoid galaxy-wide scans every tick.  
- Combine fast Lua tests with real-engine scenarios.

---

## How to use this file with GitHub Copilot

1. Attach or `@`-mention this file (and the relevant milestone brief) at the start of a session.  
2. Keep `AGENTS.md` for repo-wide commit/process rules; put **milestone-specific** procedures in the brief.  
3. Start each task by stating: lane, allowed files, success criteria, and stop condition.  
4. End with an evidence-ladder status line and either `DONE`, `not_converged`, or `BLOCKED: …`.

When in doubt: **smaller slice, stronger evidence, mechanics over atmosphere.**
