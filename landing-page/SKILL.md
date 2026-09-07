---
name: "landing-page"
description: "How to build a landing page. Black-white simple default, Uthman voice copy."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Landing Page

## Visual defaults — start simple

- **Black and white first.** No color palette unless asked. Start with a clean black-on-white (or white-on-black) design and only introduce color if it's explicitly requested.
- **No gradients**, ever, unless explicitly asked for.
- **No glowing dots, glow effects, or ambient decoration.** These are extremely common in AI-generated landing pages and read as generic/templated — actively avoid the pattern.
- **No shadows by default.** No drop shadows on cards, buttons, or text unless explicitly asked. Flat, simple, no "dumb shadow" depth effects.
- **No status badges** (build status, npm version, license badges, etc.) on a landing page — those belong in a README, not marketing copy.

## Icons and fonts

- Icons: use **Google Icons** (Material Symbols) or **Phosphor Icons**. Don't reach for a random icon pack.
- Fonts: use **Google Fonts**. Pick something that fits the project's tone, but don't default to an overused choice without thinking about it.

## Copy — this is the part that matters most

Copy should read the way Uthman wants it to read — not a generic "landing page voice." Concretely:

- **Minimal em dashes.** Prefer a period or restructured sentence.
- **No filler/hype language** — no "supercharge," "unlock," "seamless," "blazing fast" unless it's genuinely true and specific, and even then, prefer concrete claims over adjectives.
- **Write headers and copy the way Uthman would say it himself** — direct, plain, no marketing voice — unless he explicitly asks you to write it yourself/take a pass at it. Default to matching his voice rather than substituting your own.
- If given rough copy or bullet points, tighten and structure them rather than replacing them with new phrasing that changes what he said.

## Structure — start minimal, add only what's asked

- Header/nav, a clear one-line statement of what the project is, and a primary call to action is usually enough to start.
- Don't add sections (testimonials, pricing tiers, feature grids with icons, "how it works" step diagrams) unless the content actually exists and was asked for. An empty or filler section is worse than no section.
- Follow the same "boring first" instinct as the architecture-planning skill: plain HTML/CSS is often enough for a landing page; don't reach for a framework unless the project's stack already uses one or there's a specific interactivity need.

## What to avoid

- Don't add any of the default-off decorations (glow, gradient, shadow, badges) "to make it look more finished" — simple and unfinished-looking is the correct starting point; decoration is opt-in, not a default polish pass.
- Don't write copy in a generic SaaS-marketing voice — match how Uthman actually talks about the project, based on what he's said about it in this conversation or provided as source material.
- Don't over-build the page structure beyond what content actually exists yet.