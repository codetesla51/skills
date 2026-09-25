---
name: "design"
description: "How to design any UI (landing pages, apps, dashboards): design systems, hierarchy, responsive by default, black-white simple default, Uthman voice copy."
version: 1
created: "2026-09-25"
updated: "2026-09-25"
---
# Design

This applies to any visual UI work — landing pages, app screens, dashboards, tools — not just landing pages. (Older name: landing-page.)

## Design systems — define tokens, don't wing it per element

Before styling individual elements, fix a small set of reusable values and use only those, everywhere:

- **Color:** a small set (background, foreground, one muted/secondary tone, one accent at most) — not colors picked ad hoc per component. Adding a new color for one button is a smell.
- **Type scale:** a fixed set of sizes (e.g. 14/16/20/28/40px) used consistently for the same role every time — body text is always the same size, all h2s are the same size. Don't pick a one-off font size for a single element.
- **Spacing scale:** a fixed set of spacing values (e.g. multiples of 4px: 4/8/16/24/32/48/64) for padding/margin/gaps — not arbitrary pixel values chosen per element. Consistent spacing is what makes a layout look designed instead of assembled.
- **Reuse components, don't reinvent them.** One button style, one card style, one input style — reused everywhere they appear, not a slightly different version each time they show up.

## Hierarchy — guide the eye with structure, not decoration

- Hierarchy comes from **size, weight, color contrast, and whitespace** — a bigger/bolder headline with room to breathe around it, not a colored badge, an icon, or a border to draw attention.
- The most important thing on the screen should be the biggest/boldest/most isolated by whitespace. Everything else recedes in that order — don't have three equally loud elements competing.
- Group related things close together, separate unrelated things with more space (proximity = relationship). This does more visual organizing work than borders or dividers.
- Whitespace is a design choice, not empty space to be filled — resist the urge to fill gaps with decoration.

## Responsive design — non-negotiable, on every screen, every time

Every UI is built responsive from the start — this is never an afterthought or a "we'll fix it later." Assume it will be viewed on a phone, a tablet, and a wide desktop monitor, and design for all three every time, not just the one screen size being previewed.

- **Mobile-first.** Design/build the narrow layout first, then expand outward — it's easier to add space at wide sizes than to cram a wide layout into a narrow one.
- **Fluid, not fixed.** Use relative units (%, rem, `fr`, `minmax()`, `clamp()`) and flexbox/grid over fixed pixel widths, so layout adapts rather than breaking at arbitrary sizes.
- **No horizontal scroll, ever**, on any screen width, unless it's an intentional horizontal-scroll component (a carousel). Anything else scrolling sideways is a bug.
- **Touch targets ≥44px** on anything tappable (buttons, links, nav items) — not just visually big enough, actually big enough to tap reliably on a phone.
- **Text stays readable at every width** — no font-size so small it's unreadable on mobile, no line so wide it's unreadable on desktop (roughly 50-75 characters per line is the comfortable range for body text).
- **Images and media scale**, never overflow their container, never force a fixed pixel width that breaks on a narrow screen.
- **Actually check multiple widths** before calling it done — narrow (~375px), medium (~768px), and wide (~1440px), not just whatever the artifact preview happens to render at.

## Visual defaults — start simple

- **Black and white first, always.** This is not a suggestion, it's the default starting point for every design unless explicitly told otherwise. No color palette unless asked.
- **Not pure black/pure white.** `#000000` on `#FFFFFF` reads harsh and cheap. Use near-black/near-white variants instead — something like a `#0a0a0a`–`#151515` background with an off-white `#f5f5f0`–`#fafaf8` foreground (or the inverse). Pick one direction (dark or light) and commit to it; don't mix.
- **No gradients**, ever, unless explicitly asked for.
- **No glowing dots, glow effects, ambient blur shapes, or neon accents.** These are extremely common in AI-generated UI and read as generic/templated — actively avoid the pattern, full stop.
- **No shadows by default.** No drop shadows on cards, buttons, or text unless explicitly asked. Flat, simple, no "dumb shadow" depth effects.
- **No status badges** (build status, npm version, license badges, etc.) on a landing page — those belong in a README, not marketing copy.

## Design over decoration

- **No generic nav.** A one-pager usually doesn't need a nav bar at all — a logo/name and maybe one link (or none) beats a full nav with 5 links to sections that don't exist yet. Don't add a hamburger menu, a sticky nav, or placeholder nav links "because pages usually have one." When a nav is genuinely needed (an app with real sections), it still follows the design-system rule: one style, reused, responsive (collapses sensibly on mobile — doesn't have to be a hamburger, but it must not break or overflow).
- **No generic footer.** Skip the multi-column footer (About/Product/Company/Legal, a row of social icons, "© 2026 all rights reserved") unless that content genuinely exists. A single line with a contact link, or nothing, is usually correct.
- If in doubt whether an element earns its place, the default is to leave it out — every element should be there because the content demands it, not because "pages/apps like this usually have one."

## Icons and fonts

- Icons: use **Google Icons** (Material Symbols) or **Phosphor Icons**. Don't reach for a random icon pack.
- Fonts: use **Google Fonts**. Pick something that fits the project's tone, but don't default to an overused choice without thinking about it.

## Copy — this is the part that matters most (landing pages / marketing copy)

Copy should read the way Uthman wants it to read — not a generic "landing page voice." Concretely:

- **Minimal em dashes.** Prefer a period or restructured sentence.
- **No filler/hype language** — no "supercharge," "unlock," "seamless," "blazing fast" unless it's genuinely true and specific, and even then, prefer concrete claims over adjectives.
- **Write headers and copy the way Uthman would say it himself** — direct, plain, no marketing voice — unless he explicitly asks you to write it yourself/take a pass at it. Default to matching his voice rather than substituting your own.
- If given rough copy or bullet points, tighten and structure them rather than replacing them with new phrasing that changes what he said.

## Structure — start minimal, add only what's asked

- A clear one-line statement of what the thing is and a primary call to action (for a landing page), or the actual core function (for an app screen), is usually enough to start. No nav, no footer, no extra sections/screens unless asked.
- Don't add sections or screens (testimonials, pricing tiers, feature grids with icons, "how it works" step diagrams, settings pages) unless the content actually exists and was asked for. An empty or filler section is worse than no section.
- Follow the same "boring first" instinct as the architecture-planning skill: plain HTML/CSS is often enough; don't reach for a framework unless the project's stack already uses one or there's a specific interactivity need.

## What to avoid

- Don't add any of the default-off decorations (glow, gradient, shadow, badges) "to make it look more finished" — simple and unfinished-looking is the correct starting point; decoration is opt-in, not a default polish pass.
- Don't use pure `#000`/`#FFF` — always a near-black/near-white variant instead.
- Don't add a nav or footer by default just because pages "usually have one" — every section earns its place through actual content.
- Don't pick colors, font sizes, or spacing values ad hoc per element — use the fixed design-system scale every time.
- Don't design for one screen size and call it done — check narrow, medium, and wide before considering any UI finished.
- Don't write copy in a generic SaaS-marketing voice — match how Uthman actually talks about the project, based on what he's said about it in this conversation or provided as source material.
- Don't over-build the structure beyond what content actually exists yet.
