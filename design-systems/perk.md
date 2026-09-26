# Perk — Style Reference
> electric lime on warm parchment paper

**Theme:** light

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Perk operates as an electric yellow command center on warm off-white paper — every screen treated like editorial product design. Dominant lime accent (#beff50) charges through an otherwise quiet achromatic palette of near-black ink (#14140f) and parchment cream (#f5f5eb). Single-source typography: OTSono carries everything from 90px display down to 10px micro-labels, weight 500 for emphasis, 400 for body, tight tracking at scale (-0.03em), generous all-caps tracking (0.1em) for tiny eyebrows. Soft radii — 28px cards and primary buttons, 9999px pills and tags — zero elevation, tonal contrast and whitespace separate layers.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Electric Lime | `#beff50` | `--color-electric-lime` | Primary action bg, hero fills, accent panels — the singular chromatic charge |
| Off-Black Ink | `#14140f` | `--color-off-black-ink` | Body text, headings, icon fills, link borders, button text |
| Off-White Canvas | `#f5f5eb` | `--color-off-white-canvas` | Card surfaces, secondary page bg — warm parchment |
| Pure White | `#ffffff` | `--color-pure-white` | Highest surface level, card fills, input fields |
| Ash | `#d2d2c8` | `--color-ash` | Borders, dividers, subtle structural lines |
| Graphite | `#6e6e64` | `--color-graphite` | Muted body text, secondary copy |
| Deep Charcoal | `#30302a` | `--color-deep-charcoal` | Dark card surfaces, inverted blocks |
| Stone | `#919183` | `--color-stone` | Faint borders, decorative strokes |
| Smoke | `#b9b9b7` | `--color-smoke` | Placeholder backgrounds, subtle wash zones |

## Tokens — Typography

### OTSono — Single-family system: 90px display (500, 0.89, -0.03em) through 16px body (400, 1.5) to 10px micro-labels. 500 = headings/labels/CTAs; 400 = body/supporting. 0.1em tracking on small caps reserved for eyebrows and tags. · `--font-otsono`
- **Substitute:** Inter, system-ui sans-serif
- **Weights:** 400, 500
- **Sizes:** 10, 12, 14, 16, 17, 18, 20, 22, 24, 28, 32, 40, 60, 80, 90, 200
- **Line height:** 0.83–1.50
- **Letter spacing:** -0.03em at 28px+, normal body, 0.1em all-caps micro-labels

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| eyebrow | — | — | 10px | 1.4 | 1px | `--text-eyebrow` |
| caption | — | — | 12px | 1.33 | 1.2px | `--text-caption` |
| body-sm | — | — | 14px | 1.29 | — | `--text-body-sm` |
| body | — | — | 16px | 1.5 | — | `--text-body` |
| subheading | — | — | 22px | 1.18 | — | `--text-subheading` |
| heading | — | — | 28px | 1.14 | -0.56px | `--text-heading` |
| heading-lg | — | — | 60px | 1 | -1.8px | `--text-heading-lg` |
| display | — | — | 90px | 0.89 | -2.7px | `--text-display` |

## Tokens — Spacing & Shapes

**Base unit:** 4px · **Density:** comfortable

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 4 | 4px | `--spacing-4` |
| 8 | 8px | `--spacing-8` |
| 12 | 12px | `--spacing-12` |
| 16 | 16px | `--spacing-16` |
| 20 | 20px | `--spacing-20` |
| 24 | 24px | `--spacing-24` |
| 32 | 32px | `--spacing-32` |
| 40 | 40px | `--spacing-40` |
| 60 | 60px | `--spacing-60` |
| 64 | 64px | `--spacing-64` |
| 72 | 72px | `--spacing-72` |
| 80 | 80px | `--spacing-80` |
| 96 | 96px | `--spacing-96` |
| 220 | 220px | `--spacing-220` |
| 224 | 224px | `--spacing-224` |

### Border Radius

| Element | Value |
|---------|-------|
| tags | 9999px |
| cards | 28px |
| inner | 18px |
| pills | 9999px |
| inputs | 8px |
| buttons | 28px |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 80-120px
- **Card padding:** 32-48px
- **Element gap:** 16-24px

## Components

### Primary Action Button (Lime Pill)
Background #beff50, text #14140f, radius 28px, padding 16px × 16px/12px. Weight 500, 16px. The only filled button — lime on off-white is the singular action signal.

### Ghost Text Button
Transparent bg, text #14140f or #6e6e64, no border. Weight 500 at 14px, 400 at 16px. Nav items, inline links, tertiary actions.

### Underline Link
Text inherits body color, 1px bottom border #14140f. Weight 400–500, 14–16px. The underline is the affordance.

### Parallax Card
Background #f5f5eb parchment, radius 28px, padding 32–48px, no shadow. Text #14140f, supporting copy #6e6e64. Lifted by tonal contrast alone.

### White Surface Card
Background #ffffff, radius 28px, padding 32–48px. For content needing lift above parchment.

### Dark Island Card
Background #30302a charcoal, radius 28px, white/cream text. Rare — testimonials or hero stats.

### Lime Accent Block
Full-bleed or large-area #beff50 fill. No border, no shadow. Hosts display typography. The lime IS the background.

### Inline Label Tag
Transparent or #f5f5eb bg, #14140f text, 500, 12px, uppercase, 0.1em tracking. 9999px pill or 0px inline. Category marker above headings.

### Input Field
Background #ffffff, 1px #d2d2c8 border, radius 0–8px. 400, 16px. Border IS the affordance.

### Section Divider
1px solid #d2d2c8. Rules, not whitespace alone, mark section boundaries.

### Icon Container
16–24px glyphs, #14140f, no background. Icons are typographic, not illustrated.

### Logo Mark
Wordmark in #14140f top-left. Single weight, no separate logomark.

## Do's and Don'ts

### Do
- Use #beff50 as the ONLY filled button color
- 28px on all cards and primary buttons, 9999px on pills and tags
- Weight 500 headings/labels/CTAs; 400 body/supporting
- -0.03em tracking at 28px+; default body; 0.1em uppercase micro-labels
- Surface stack white → parchment → lime; never shadows
- #14140f for all text (pure #000 only in inputs)
- Section gaps 80–120px

### Don't
- Do not add box-shadows to cards
- Do not use #000000 for body text
- Do not introduce blue, red, or any secondary accent
- Do not mix border-radius values within a component type
- Do not use system fonts for display sizes
- Do not crowd lime buttons — give them room
- Do not use 600 or 700 weights — 400 and 500 only
- Do not add gradients

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Page Canvas | `#ffffff` | Primary page background |
| 1 | Off-White Card | `#f5f5eb` | Feature cards, secondary blocks |
| 2 | Lime Accent Surface | `#beff50` | Hero bands, accent panels, action backgrounds |
| 3 | Dark Island | `#30302a` | Rare inverted blocks |

## Elevation

No shadows. Layers separate through tonal contrast: white canvas → parchment card → lime accent → dark island.

## Imagery

Photography and screenshots as editorial inserts — full-bleed or inside 28px cards, on parchment or white. Explanatory, not decorative. Icons are typographic glyphs 16–24px, monochromatic #14140f. Lime never appears in imagery.

## Layout

Max-width ~1200px centered, generous outer padding. Hero: large display type (60–90px) on parchment or lime, often paired with visual right. Sections alternate white/parchment tonal bands. Mixed arrangement: full-width headlines, 2-column splits, 3-column grids at 28px radii. 80–120px section rhythm. Single top bar: ghost links + lime pill CTA right. Dark (#14140f) footer with white text.

## Agent Prompt Guide

- Text: #14140f · Canvas: #ffffff · Card: #f5f5eb · Border: #d2d2c8 · Accent: #beff50

1. **Primary Action Button**: #beff50 bg, dark text, 9999px radius, compact pill padding. The filled treatment for the main CTA.
2. **Feature card grid**: 3 columns on white. Cards #ffffff, 28px radius, 40px padding, no shadow. Eyebrow 12px/500/uppercase/0.1em #6e6e64. Title 28px/500 #14140f. Body 16px/400 #6e6e64.
3. **Lime accent panel**: full-bleed #beff50, 80px vertical padding. Display 80px/500 #14140f, -0.03em, 0.9 leading. Ghost text button below.
4. **Dark footer**: #14140f bg, 80px padding. Link lists in #f5f5eb 14px/400. Headers 12px uppercase/0.1em/500 #d2d2c8.

## CSS Custom Properties

```css
:root {
  --color-electric-lime: #beff50;
  --color-off-black-ink: #14140f;
  --color-off-white-canvas: #f5f5eb;
  --color-pure-white: #ffffff;
  --color-ash: #d2d2c8;
  --color-graphite: #6e6e64;
  --color-deep-charcoal: #30302a;
  --font-otsono: 'OTSono', ui-sans-serif, system-ui, sans-serif;
  --text-display: 90px;
  --text-heading-lg: 60px;
  --text-heading: 28px;
  --text-body: 16px;
  --text-eyebrow: 10px;
  --radius-cards: 28px;
  --radius-buttons: 28px;
  --radius-pills: 9999px;
  --page-max-width: 1200px;
  --section-gap: 80-120px;
}
```
