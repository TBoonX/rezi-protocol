# Razi 3.x — multi-agent coding practices

Canonical copy for agents working inside this repository lives next to the planning briefs:

- **Primary (clone workspace):** `custom_finalization/Razi-multi-agent-practices.md` 

If you only have this repo checked out, use the full practices document below — kept in sync with the clone-root copy.

---

## Situation (one line)

The campaign machinery largely exists. Agent work is: **reconcile narrative with current mechanics → fill/connect authoring surfaces → prove one playable story segment → expand → story-enabled campaign acceptance.** Do **not** build a second quest/progression engine.

Prefer **existing Copilot coordinated sessions + this repo’s GitHub Actions / FUnit** for the first milestone.

---

## Do first

1. **Contract before agents** — milestone brief: goal, non-goals, allowed files, interfaces, numbered success criteria, stop/`BLOCKED`, spoiler boundary.  
2. **Mechanics win over prose** — precedence: runtime evidence → current code → portal → old locale. Do not restore removed hardware without an explicit decision.  
3. **Do not rebuild the quest engine** — Journal/quests/projects/Convergence stay; deliver slots, bypass connections, campaign proof.  
4. **Three lanes, one integration owner** — gameplay · narrative/locale · validation; disjoint files; one live Factorio owner.  
5. **One playable slice before the galaxy** — then expand; enable story globally only after the first slice is coherent.

---

## Every milestone

- **Evidence ladder:** implemented → Lua/unit → Factorio/FUnit → human-accepted. Never collapse levels.  
- **Mechanical story gates:** required slots, lengths, IDs, bypass title resolution, claims ⊆ tracked mechanics.  
- **Objective / context / lore** layers; mystery ≠ missing orientation.  
- **Trigger + recovery** contracts (destroy, reload, multiplayer, missing optional mod).  
- **Procedures in the milestone brief**, not a growing mega-prompt.  
- **Critic:** criteria + evidence only; cap = not shipped.  
- **Equal compute** before claiming multi-agent wins; report cost per accepted milestone.  
- **Harness enforces** (CI/FUnit/validators/worktrees); prompts advise.  
- **Reference modpack** + optional-content matrix; essential story without optional worlds.  
- **`BLOCKED:`** on conflicting inputs — do not invent telemetry or entities.

---

## Avoid

Seven parallel system rewrites · agent self-grade as acceptance · auto-retire lore from one signal · spoiler/security rules only in prose · Story Missions scenario architecture as a rewrite target · forced drama that breaks the factory game.

---

## Human checkpoint (spoiler-free)

Report tone, clarity, pacing, reading burden, player freedom, evidence-ladder status, risks, decisions needed. **No** plot outlines, revealing excerpts, or spoiler screenshots in human progress reports.

---

## Minimum milestone checklist

1. [ ] Contract written  
2. [ ] Mechanics match prose  
3. [ ] Lane isolation + live-game owner  
4. [ ] Mechanical tests green  
5. [ ] Factorio evidence for changed behavior  
6. [ ] Spoiler-free human checkpoint  
7. [ ] Cost note for accepted slice  

Full detail, acceptance package tables, writing rules, and Factorio constraints: see the clone-root `custom_finalization/Razi-multi-agent-practices.md` (authoritative long form).
