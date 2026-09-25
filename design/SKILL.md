---
name: "design"
description: "Index for all design skills. Use when doing any UI/design work."
version: 3
created: "2026-09-07"
updated: "2026-09-25"
---
# Design Router

## When to Use
Use for any UI, landing page, app screen, or visual design task; load referenced skills as needed.

## Procedure
1. This is a router, not a bundle: load ONLY the sub-skill(s) the current task actually needs, never all of them.
2. **ui-planning-and-scaffolding** — ask who/what/platform/complexity/constraints before scaffolding; boring stack first.
3. **frontend-design** — distinctive identity, token plan reviewed vs brief, one bold element, user-voiced copy. Layered with Uthman's personal defaults inside that skill (black-and-white-first, no decoration by default) when the brief doesn't state its own direction.
4. **ui-ux-pro-max** — searchable guidance via scripts/search.py (design-system, domain, stack); never fabricate 0-result.
5. **visual-defaults** (formerly landing-page, now covers any UI not just landing pages) — design systems (fixed color/type/spacing scale), hierarchy via size/weight/spacing, mandatory responsive at narrow/medium/wide, black-white flat default, no glow/gradient/shadow/badges unless asked, no generic nav/footer, Uthman-voice copy.
6. **explainer** — report and explain high-level-first then mechanism with why, for describing the finished design back to him.

Typical order for a from-scratch build: ui-planning-and-scaffolding (stack/constraints) → frontend-design (identity/token plan, reviewed for uniqueness) → visual-defaults (apply the concrete rules — colors, responsive, no decoration) → build → explainer (report what was built and why).

## Pitfalls
- Building UI before planning answers.
- Generic templated defaults (see frontend-design's cliché list).
- Treating this router and visual-defaults as interchangeable — this file routes, visual-defaults has the actual concrete rules.

## Verification
1. Planning done, plan reviewed for uniqueness, pre-delivery checklist run.
2. Responsive checked at narrow/medium/wide before calling it done.
