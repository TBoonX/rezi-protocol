**The strongest lesson is that a story-heavy factory mod needs two designs working together: a compelling narrative and a resilient progression system.** The most useful references for Razi are **Story Missions for presentation**, **Mining Space Industries II for missions inside an open-ended factory**, and **Nullius/Space Exploration for making the industrial journey itself meaningful**.

I examined author descriptions, development articles, FAQs and changelogs. Below, documented experiences are distinguished from my recommendations. **No plot revelations are included**, though linked pages may contain spoilers.

## 1. Projects worth learning from

| Project | What makes it relevant | Documented lesson and application to Razi |
|---|---|---|
| **[Story Missions](https://mods.factorio.com/mod/Story-Missions)** | Ten scripted missions, mandatory/optional objectives, briefings, dialogue and authored environments | Strong example of clear, bounded episodes. Its changelog also shows how much work goes into objective wording, triggers, transitions and updates—not just writing. **Use star systems as coherent chapters, without necessarily resetting the factory between them.** |
| **[Mining Space Industries II](https://mods.factorio.com/mod/Mining-Space-Industries-II)** | Missions and technology recovery integrated into ordinary factory progression; an in-game mission panel | Probably the closest reference for integrating authored objectives into sandbox play. Its fixes cover destroyed objectives, vehicle interactions, force changes and technology conflicts. **Specify what happens when players damage, move or bypass mission-related objects.** |
| **[Nullius](https://mods.factorio.com/mod/nullius)** | An overarching purpose expressed through production, research and changes to the world | The premise explains the available resources and industrial goals. It is not primarily a dialogue campaign. **Make Razi’s production and logistics embody the story, rather than relying on Archive prose to provide all meaning.** |
| **[Space Exploration](https://mods.factorio.com/mod/space-exploration)** | Long interplanetary progression with discoveries, secrets and engineering challenges | Its documentation emphasizes gradual introduction of mechanics and warns that extra mods can undermine intended resource/energy constraints. **Protect the conditions that make each region matter, and accommodate long gaps between discoveries.** |
| **[Exotic Industries](https://mods.factorio.com/mod/exotic-industries)** | Distinct technological ages, discovery and an in-game reference | A [completed-playthrough review](https://blog.xaviershay.com/articles/factorio-exotic-industries-review.html) praises early/midgame progression but criticizes late research that adds cost without interesting new mechanics. **Each chapter needs a meaningful change in play—not simply another expensive gate.** |
| **[Freight Forwarding](https://mods.factorio.com/mod/FreightForwarding)** | Geography, resource placement and research deliberately require different transport solutions | Not a story-first campaign, but a strong example of a coherent journey built from mechanics. **Give travel and trade a practical reason before attaching narrative significance to them.** |
| **[Ultracube](https://mods.factorio.com/mod/Ultracube)** | A distinctive central constraint supported by custom tracking and player-facing tools | Its compatibility guide explains how scripted entity movement/destruction can invalidate tracking. **Important story state must survive all supported ways players and other mods manipulate the world.** |

**Version caution:** Story Missions is no longer only a pre-2.0 example. Its current documentation lists a Factorio **2.0** version, explicitly **without Space Age support**. Mining Space Industries II’s changelog lists a **2.1 port**. These are design references, not assurances that they can be installed alongside Razi.

## 2. Story Missions: the particularly useful lessons

GreenFlag’s [firsthand development article](https://alt-f4.blog/ALTF4-54/) describes learning from Factorio’s tutorial and New Hope scenario files, then producing the original five missions over roughly three to four months. The useful delivery techniques are straightforward:

- **Briefings establish the situation and objective.**
- **Short in-world dialogue accompanies action.**
- **Mandatory and optional tasks provide structure and room for exploration.**

However, its [changelog](https://mods.factorio.com/mod/Story-Missions/changelog) is more instructive than the feature list. It records fixes to unclear objectives, counters after deconstruction, missing technologies, difficulty, mission unlocks and loading the wrong next scenario. The author still advises against updating during a mission.

**For Razi:** imitate the clarity of an episode, not necessarily its scenario architecture. Razi’s persistent, multi-system factory allows much less control over when players arrive, what they have already built and which order they choose.

Also, treat **writing, implementation and playability as separate completion states**. Older Story Missions updates explicitly reported different progress for mission design, scripting and story.

## 3. What story changes about factory-mod development

### A. Objectives must be precise even when the story is mysterious

The player should always understand **what can be done now, where, and what counts as completion**. Mystery can surround the explanation or consequences.

For Razi, keep three layers distinct:

| Layer | Purpose |
|---|---|
| **Objective** | Concrete action and observable requirements |
| **Context** | Brief explanation of why the action matters |
| **Optional narrative** | Deeper evidence, character perspectives and discoveries |

This directly addresses the confusing prose we identified earlier. **Unexplained terminology must not obscure the task.**

### B. Narrative triggers need failure and recovery rules

Mining Space Industries II’s [changelog](https://mods.factorio.com/mod/Mining-Space-Industries-II/changelog) documents mission failures involving destroyed vehicles, missing silos and objectives damaged before arrival.

For every significant Razi beat, agents should define:

**Eligibility → triggering evidence → persistent completion → presentation → recovery.**

That includes answers to questions such as: does prior construction count? What happens after destruction? Can another teammate complete it? What if the relevant optional mod is absent?

A missing dependency must not quietly skip a vital explanation—or create an unwinnable objective.

### C. Story pacing must tolerate factory pacing

Players can spend hours rebuilding infrastructure, arrive with advanced equipment, or return after weeks away. Consequently, I recommend:

- milestone-driven delivery rather than arbitrary elapsed-time narration;
- a short “where we are” summary in the Journal;
- replayable messages instead of essential one-time chat;
- queued notifications when several milestones happen together;
- reading that does not demand attention during emergencies.

These are recommendations for Razi, not features I verified in every reference project.

### D. Avoid forcing drama at the expense of the factory game

Wube’s own development history provides unusually strong cautionary evidence:

- [FFF-306](https://factorio.com/blog/post/fff-306) describes removing an intense timed defence objective after feedback that it did not match players’ expectations.
- [FFF-327](https://factorio.com/blog/post/fff-327) explains scrapping a polished tutorial whose forced sequence undermined Factorio’s natural progression.

**For Razi:** a dramatic event should create an interesting engineering decision, not merely interrupt building or punish a player for reading slowly. Major timers, forced losses and irreversible restrictions need explicit approval.

### E. Compatibility includes balance and narrative—not just loading

[Nullius’s FAQ](https://mods.factorio.com/mod/nullius/faq) explains that compatibility requires appropriate ingredients, crafting categories, research packs and prerequisites. Space Exploration additionally warns that technically functioning mods can remove the constraints underlying its experience.

For Razi, each supported dependency combination must preserve:

- a reachable production/research path;
- the intended reason to visit and use a world;
- accurate objective text;
- essential narrative context.

**A successful launch proves none of those by itself.**

## 4. How this should change our Razi plan

For each system or cross-system milestone, require a compact acceptance package:

| Area | Acceptance evidence |
|---|---|
| **Progression** | Required technologies, recipes, resources and transport are reachable from the preceding milestone |
| **Story** | Text matches actual mechanics; required context is available without optional worlds or future revelations |
| **Triggers** | Correct timing, no premature reveals, no duplicate rewards/messages |
| **Recovery** | Relevant save/reload, destruction/rebuilding, prior completion and multiplayer cases |
| **Presentation** | Clear objectives, readable GUI, replayable context and valid localization |
| **Experience** | A short playtest checks comprehension, pacing and whether the milestone adds worthwhile gameplay |

Use two testing tracks: **prepared scenario fixtures** for fast regression tests and **continuous playthrough saves** to expose accumulated problems and pacing. Fixtures alone can accidentally supply something ordinary progression cannot obtain.

Razi already uses [FUnit](https://mods.factorio.com/mod/funit); extend that rather than replacing it. FUnit supports real events, delayed assertions, scenario/save testing and machine-readable reports. Automated checks can verify unlock order and persistence; **they cannot establish that the story is engaging or understandable**.

**My main recommendation is to add a “narrative acceptance contract” to each gameplay milestone before agents start writing it.** One gameplay owner defines what the engine can actually establish, writers work within that contract, and an editor checks clarity and continuity. Your checkpoint then asks spoiler-free questions about reading burden, freedom, pacing and comprehension—not what happens next.

# Correction

**we should build the story around Razi’s existing progression, quests, projects and Journal, not turn it into Story Missions.** That comparison is useful for clarity and testing, not as an architecture to copy.


I would adjust our plan accordingly:


- **Reuse existing milestones as narrative anchors.** Research, system access, project completion and deliveries already provide meaningful progression. New tracking needs a demonstrated gap—not merely a writer wanting a more specific scene.
- **Respect experienced players.** Explain Razi-specific requirements and consequences, not ordinary Factorio mechanics. Objectives should communicate the destination without prescribing every construction step.
- **Provide memory support, not constant instruction.** The Journal should make it easy to recover *what I achieved, what currently matters, and why*. Short contextual reminders can reuse recorded progress; we do not need a detailed history of every action.
- **Match claims to available evidence.** If the game establishes research completion, the prose must not claim the player personally visited a location or performed an untracked action.


**The principle: assume competence, not perfect memory.** Optional explanations and retrospective summaries are preferable to mandatory tutorials or repeated interruptions.

-------------------------

## Why are so many dependencies optional?


Looking at the [reviewed branch’s `info.json`](https://github.com/Raziphel/razi-protocol/blob/7a0ee5c21e74c5aebf37cddcdac2c43232719d1e/info.json), its dependency list mixes several things:

This is a historical review of that branch. The current Factorio 2.1 decision removed Pelagos and four other optional mods without compatible releases; see the current modpack decision in `Razi-protocol-3_situation.md`.


| Declaration | Meaning | Razi examples |
| --- | --- | --- |
| No prefix | Required | K2SO, PlanetsLib, many core planets |
| `~` | **Required**, but does not impose load order | Nexus Bosses, Orbital Cannon |
| `?` | Optional integration; applies dependency ordering/version constraints when installed | Cerys, Pelagos, LTN, visual and enemy mods |
| `+` | Recommended rather than hard-required | Planet Express, Frozeta, upgraded rocket turrets |
| `!` | Explicitly incompatible | Conflicting overhaul or replacement mods |



These meanings come from [Factorio’s dependency documentation](https://lua-api.factorio.com/latest/auxiliary/mod-structure.html#dependencies). **A long dependency list is therefore not a list of everything you must install.**


The optional entries serve different purposes:


**Player preferences.** Logistics helpers, visual changes and additional enemies change convenience, presentation or challenge. Requiring all of them would impose one particular play style.


**Additional worlds.** Razi has conditional integration for extra destinations. This permits a smaller installation while accommodating a broader campaign when those worlds are present.


**Compatibility patches.** Some entries only matter when another optional mod is installed—for example, compatibility between additional enemies and K2.


**Explicit integration/load ordering.** Listing an optional mod tells Factorio about the relationship; it does not necessarily mean Razi considers that mod part of its core experience.


Those are supported interpretations of the configuration, **not a confirmed explanation from the author for every individual choice**.


### The consequence for our plan


**Optional to install does not necessarily mean optional to progress through once installed.** Razi can incorporate installed worlds into later progression requirements, depending on settings.


We should therefore establish **one reference mod configuration for development and acceptance**, plus a smaller set of supported variations. Essential story understanding must work without optional content; optional worlds can enrich it. And we should correct outdated documentation: parts of the README still call Nexus optional, while the reviewed manifest requires it.