---
name: "ui-planning-and-scaffolding"
description: "How to plan and scaffold a UI before writing code. Ask structured questions first, never scaffold silently."
version: 3
created: "2026-09-07"
updated: "2026-09-26"
---
# UI Planning & Scaffolding

## Core rule: ask before scaffolding

Never generate UI folder structure, component skeletons, or a framework choice without first asking Uthman the questions below and getting real answers. A UI decision made without answers to these is a guess, and guesses here are expensive to undo (framework choice especially — swapping React for something else later is a rewrite, not a refactor).

If some answers are already obvious from context (e.g., this is clearly a Quickshell module for the existing dotfiles rice, or clearly a CLI tool with no visual UI), skip asking about those specific points and state the assumption instead of asking — but still ask about anything genuinely undecided.

## Part 1 — Planning: questions to ask, in order

**1. Who is this for?**
- Just Uthman (personal tool, dotfiles, internal script)?
- Other developers (an open-source project's docs site, a CLI's help output)?
- Non-technical end users (kyfram template users, a public-facing product)?
This changes almost everything downstream — a personal tool can be ugly and fast to build; something for non-programmers needs to be self-explanatory with no assumed context.

**2. What does it actually need to do?**
- List the core screens/views or states, not features — "a form to create a scene, a list of existing scenes, a preview pane" not "CRUD for scenes."
- Is it read-only/display, or does it need real interactivity (forms, drag-drop, live updates)?
- Does it need to persist anything, and if so, is that already decided or part of this planning pass?

**3. What platform/surface is it on?**
- Terminal (TUI)? Web (browser)? Native desktop? A QML/Quickshell module inside the existing rice? Embedded in something else (a CLI's `--view` flag spinning up a local server, for instance)?
- This should usually already be implied by the project (see architecture-planning skill for how the broader system was chosen), but confirm rather than assume if it's not obvious.

**4. What's the complexity/lifespan of this UI?**
- Throwaway/prototype vs. something that'll be maintained and extended for years?
- This is the "boring technology" question applied to UI — a one-off internal tool doesn't need the same rigor as kyfram's `view` command, which is core to the product.

**5. Any hard constraints already decided?**
- A framework already in use elsewhere in the project (don't introduce a second UI framework into one codebase without a clear reason)
- Performance constraints (must render at 60fps, must work over SSH, must be usable on a slow machine)
- Accessibility requirements, if it's for non-technical/public users

## Proposing the stack

Once the above is answered, propose the **boring option first** per the architecture-planning skill's default stance — don't reach for the trendiest UI framework by default:

- Terminal UI → prefer a well-established Go TUI library (e.g. Bubble Tea) over hand-rolled ANSI, unless the need is trivial enough that plain `fmt.Println` genuinely suffices.
- Web UI, personal/internal → plain HTML/CSS/vanilla JS is often enough; don't reach for a full framework for a one-page internal tool.
- Web UI, product-facing with real interactivity → a mainstream framework (React, or whatever's already used elsewhere in the project) is a reasonable, boring choice — the goal isn't "no framework ever," it's "don't add a framework, or a second framework, without the interactivity actually needing one."
- Quickshell/QML → already the established pattern in the dotfiles project; match existing module conventions (see `/areas/hyprland-quickshell-migration.md` and existing `modules/*.qml` patterns) rather than introducing a new UI approach into that rice.

State which option is the boring default and which would be the "innovation token" spend, same framing as the architecture-planning skill, so the tradeoff stays visible.

## Part 2 — Scaffolding

Only scaffold once the planning questions above are actually answered in this conversation (who it's for, what it does, platform, complexity/lifespan, constraints, chosen stack). Don't scaffold on assumptions.

**Scaffolding principles:**
- **Match existing project conventions first.** If this UI lives inside an existing codebase (e.g., the dotfiles Quickshell modules, or an existing web project), scaffold to match that project's existing folder layout and naming, not a generic template. Look at how other modules/components in the same project are structured before creating new patterns.
- **Start minimal.** Scaffold only the screens/views actually named in the planning answers — don't pre-generate placeholder folders for features that weren't asked for "in case they're needed later." Empty scaffolding is clutter, not preparation.
- **One clear entry point.** Whatever the platform, there should be one obvious file someone opens first to understand how the UI is wired together (a `main.qml`, an `App.tsx`, a `main.go` with the TUI's `Init`/`Update`/`View`). Name it obviously, don't bury it.
- **Follow the coding-style skill inside any generated code** — simple, self-explanatory, idiomatic to the language/framework in question, comments explain behavior not syntax.

**Structure by platform:**

Terminal UI (Bubble Tea or similar):
```
cmd/<tool>/main.go     entry point, wires model + program
internal/ui/
  model.go             the Bubble Tea Model struct + Init/Update/View
  styles.go            lipgloss styles, kept separate from logic
  keys.go              keybinding definitions, if more than a couple
```

Web (vanilla, personal/internal tool):
```
index.html
style.css
script.js
```
Don't split into more files than the project's actual complexity warrants — a single-page internal tool doesn't need a build step or module system.

Web (framework-based, product-facing):
```
src/
  components/          one file per reusable component
  pages/ (or routes/)  one file per top-level view
  App.tsx (or equivalent)   root composition, matches the named views from planning
```
Match whatever the existing project's convention already is if this isn't a brand-new project — don't introduce a competing structure alongside an established one.

Quickshell/QML module (dotfiles rice):
```
.config/quickshell/modules/<ModuleName>.qml
```
Follow the existing pattern from other modules in `.config/quickshell/modules/` and `Colors.qml`/`Bar.qml` conventions — reuse the matugen-driven color variables rather than hardcoding colors, matching how the rest of the rice is themed.

**After scaffolding:**
- Explain what was created and why it's shaped that way (see the explainer skill — high-level first, then the low-level reasoning for the structure chosen).
- Don't fill in real logic beyond the minimum needed to prove the scaffold runs/renders — a scaffold's job is to establish structure, not deliver the feature. Confirm the shape is right before building further on top of it.

## Forbidden rules — carry through to the build phase (brief wins)

This skill plans structure, not visuals — but pass these bans to whatever build skill follows so they aren't lost. Unless the brief explicitly asks for it, the built UI must NEVER have: a color palette (black-white first, near-black `#0a0a0a`–`#151515` / off-white `#f5f5f0`–`#fafaf8`, never pure `#000`/`#FFF`, no accent); gradients/glow/blur/neon/glass/shadows; badges/chips as decoration; icons outside Google Material Symbols or Phosphor; a generic nav/footer; single-word headline accents; ALL-CAPS eyebrows per heading; `01/02/03` markers unless true sequence; `A · B · C` meta; `WORD — fragment` labels; `→` on links; a default big-number hero or any AI cliché (cream `#F4F1EA` + terracotta `#D97757`, near-black + acid-green/vermilion, broadsheet hairlines, SaaS-card kit); per-section fade-slide-up or per-card hover lift; ad-hoc color/type/spacing; non-responsive layout (floor: 375/768/1440, ≥44px targets, no h-scroll); hype copy. Canonical wording lives in `frontend-design/SKILL.md` — that file wins on disagreements.

## What to avoid

- Don't ask all five planning questions as a wall of text if some are obviously already answered by context — ask only what's genuinely open, and state the rest as an assumption for confirmation.
- Don't pick a framework because it's popular in general — pick it because it fits the specific platform/complexity/lifespan answers just given.
- Don't scaffold "just a quick skeleton to see" before the questions are answered — an unasked-for skeleton still encodes a framework/structure decision that then has to be undone.
- Don't scaffold a UI framework's full example/demo boilerplate (unused starter components, sample routes, placeholder logos) — strip anything not actually needed for this specific UI.
- Don't add state-management libraries, CSS frameworks, or component libraries preemptively — only add them if the planning answers named a need for them, per the coding-style skill's "standard library / no dependency unless asked" default.