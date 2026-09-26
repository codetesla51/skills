# Timescale — Style Reference
> Engineering blueprint on warm graph paper

**Theme:** light

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Timescale speaks infrastructure diagrams: warm off-white canvas with subtle grid texture, bold orange statement type as visual highlighter, monospace numerals like terminal readouts. Almost entirely achromatic with exactly two chromatic punctuation marks — vivid orange for voice, chartreuse for spotlight — so color always carries intent. Dual typography: Geist for interface voice, Geist Mono for numbers, codes, emphasis. Neo-brutalist hard offset shadow (5px 5px 0px solid black) on cards and pill CTAs give a tactile blueprint-on-graph-paper quality.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Signal Orange | `#ff5b29` | `--color-signal-orange` | Headline accent, large stat numerals, emphasis spans, decorative borders — the only color with voice |
| Chartreuse Highlight | `#f5ff80` | `--color-chartreuse-highlight` | Announcement bars, highlighted callout blocks, featured chip backgrounds — spotlight wash, never CTA fill |
| Carbon Black | `#000000` | `--color-carbon-black` | Primary text, filled button backgrounds, hairline borders, hard offset shadows, icon strokes |
| Paper White | `#fafafa` | `--color-paper-white` | Page canvas, card surfaces, button text on dark fills — warm off-white, never pure #fff |
| Graphite | `#242424` | `--color-graphite` | Dark surface variant for inverted sections and elevated panels |
| Steel | `#6c6c6c` | `--color-steel` | Secondary text, subdued labels, muted helper copy |
| Ash | `#b3b3b3` | `--color-ash` | Tertiary text, disabled states, placeholder copy, very light dividers |

## Tokens — Typography

### Geist — Primary interface and heading typeface (nav, body, buttons, hero headlines). Weight 600 headings, 400 body, 700 largest display. Negative tracking tightens as size grows. · `--font-geist`
- **Substitute:** Inter
- **Weights:** 400, 600, 700
- **Sizes:** 14, 16, 18, 20, 24, 52, 80
- **Line height:** 1.10, 1.33, 1.40, 1.43, 1.50, 1.56
- **Letter spacing:** -0.03em at 52px+, -0.02em at 18-24px

### Geist Mono — Technical/numerical typeface (stat readouts, inline code, API refs). Stats always feel like live data, not marketing copy. · `--font-geist-mono`
- **Substitute:** JetBrains Mono
- **Weights:** 400, 500, 600, 700
- **Sizes:** 14, 16, 20, 24, 28, 40, 50
- **Line height:** 1.10–1.50
- **Letter spacing:** -0.02em

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| caption | — | — | 14px | 20 | — | `--text-caption` |
| body | — | — | 16px | 24 | — | `--text-body` |
| subheading | — | — | 18px | 25 | -0.02px | `--text-subheading` |
| heading-sm | — | — | 20px | 28 | -0.02px | `--text-heading-sm` |
| heading | — | — | 24px | 33 | -0.02px | `--text-heading` |
| heading-lg | — | — | 52px | 57 | -0.03px | `--text-heading-lg` |
| display | — | — | 80px | 88 | -0.03px | `--text-display` |

## Tokens — Spacing & Shapes

**Base unit:** 8px · **Density:** comfortable

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 8 | 8px | `--spacing-8` |
| 16 | 16px | `--spacing-16` |
| 24 | 24px | `--spacing-24` |
| 32 | 32px | `--spacing-32` |
| 40 | 40px | `--spacing-40` |
| 56 | 56px | `--spacing-56` |
| 80 | 80px | `--spacing-80` |
| 120 | 120px | `--spacing-120` |
| 128 | 128px | `--spacing-128` |

### Border Radius

| Element | Value |
|---------|-------|
| tags | 9999px |
| cards | 12px |
| links | 8px |
| buttons | 9999px |
| smallButtons | 4px |

### Shadows

| Name | Value | Token |
|------|-------|-------|
| sm | `rgba(0, 0, 0, 0.6) 0px 3px 4px 0px` | `--shadow-sm` |
| subtle | `rgb(0, 0, 0) 5px 5px 0px 0px` | `--shadow-subtle` |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 40-56px
- **Card padding:** 16-24px
- **Element gap:** 16px

## Components

### Announcement Bar
Full-width band, #f5ff80 chartreuse bg, Geist 14px/400 black centered text. No border, no radius. 8px vertical padding. Only for genuinely time-sensitive announcements.

### Navigation Bar
Paper White bg, thin #000 bottom border (1px). Logo left, Geist 16px/400 links, right side stats badge (Geist Mono), ghost login link, black filled CTA. ~64px tall. No shadow.

### Hero Section
Paper White canvas with subtle dot/grid overlay. Two-column: left eyebrow (Geist Mono uppercase tracking-wide), headline Geist 52-80px/600 Signal Orange with faded 'echo' word behind at reduced opacity, Geist 18px body, two CTAs side by side. Right: technical isometric illustration in black line art on Paper White.

### Filled Primary Button
Carbon Black bg, Paper White text, Geist 16px/600, 9999px pill, 10px vertical / 16-24px horizontal padding. Sentence case. Black fill is the strongest visual anchor.

### Outlined Secondary Button
Transparent bg, 1.5-2px Carbon Black border, black text, Geist 16px/600, 9999px pill, same padding.

### Logo Strip
Partner logos in grayscale/single-color black on Paper White. Geist Mono 14px uppercase 'TRUSTED BY...' caption above, hairline borders.

### Stats Banner
Card 12px radius, 1px black border, 5px 5px 0px #000 hard offset shadow. Columns divided by vertical hairlines. Stats in Geist Mono 40-50px/700 Signal Orange, labels Geist Mono 14px uppercase black beneath.

### Feature Card
Paper White, 12px radius, 1px black border, 5px 5px 0px #000 shadow. Padding 20-24px. Outlined black icon (~1.5px stroke) on top. Title Geist 20px/600, body Geist 16px/400. 2-3 column grids.

### Integration Icon Grid
Grid of 56-64px circles (9999px), 1px black border, partner logo inside. 12px gap wrapping grid.

### Enterprise Feature List
Vertical rows, no card wrapper: 24px outlined black icon left, title Geist 18px/600, body Geist 16px/400 Steel. 16-24px gaps.

### Section with Grid Pattern
Paper White with subtle dot/line grid overlay (1px black dots ~5% opacity, 20px spacing). Applied to most content sections.

### Text Input
Paper White bg, 1px black border, 4px radius, 12-16px padding. Geist 16px. No focus glow — thicker border or solid black outline on focus. Placeholder Ash.

### Pill Tag / Badge
9999px radius, Paper White bg, 1px black border, Geist Mono 12-14px uppercase/500 black text, 4px/10px padding. Feels like a version tag or label sticker.

## Do's and Don'ts

### Do
- Use Signal Orange (#ff5b29) only for emphasis — never backgrounds, body text, or non-emphasis UI
- Apply Geist Mono to all large numbers, stat readouts, inline code; Geist for everything else
- Give every elevated card the 5px 5px 0px #000 hard offset shadow
- Pills/tags 9999px, small buttons 4px, cards 12px — the full radius vocabulary
- Dual-color discipline: #ff5b29 voice, #f5ff80 highlight, achromatic everything else
- Grid-pattern backgrounds on content sections
- Tight tracking: -0.03em at 52px+, -0.02em at 18-24px

### Don't
- Don't add gradients, glassmorphism, or soft diffused shadows
- Don't use Signal Orange for CTA fills or link text — orange is voice, black fills are action
- Don't use a third chromatic color
- Don't mix Geist and Geist Mono within the same text run
- Don't round cards to anything but 12px, buttons to anything but 4px/9999px
- Don't use pure #ffffff — always #fafafa
- Don't apply colored shadows or tinted glows

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Paper White | `#fafafa` | Page canvas, section backgrounds |
| 1 | Card White | `#fafafa` | Card surfaces, often with hard offset shadow |
| 2 | Chartreuse Wash | `#f5ff80` | Announcement bar, highlighted callout blocks |
| 3 | Carbon Panel | `#000000` | Inverted sections, dark feature panels |
| 4 | Graphite Panel | `#242424` | Softer dark variant for elevated dark surfaces |

## Elevation

- **Feature Card, Stats Banner:** `rgb(0, 0, 0) 5px 5px 0px 0px`
- **Floating elements, tooltips:** `rgba(0, 0, 0, 0.6) 0px 3px 4px 0px`

## Imagery

Minimal and technical: black-line isometric illustrations of infrastructure components on Paper White. Thin uniform strokes, occasional stipple. No photography, no lifestyle imagery, no abstract gradients. Hero illustration sits in a card with hard offset shadow. Partner logos in small circular frames.

## Layout

Max-width 1200px centered content in full-bleed sections. Hero two-column split (text left, illustration right). Sections alternate Paper White and grid-pattern backgrounds, separated by hairlines or 40-56px gaps. Stats in wide banner card. Features in 2-3 column grids. Integrations in wrapping icon grids. Flat top nav, no sticky behavior visible.

## Agent Prompt Guide

- Primary text: #000000 · Background: #fafafa · Border: #000000
- Accent (emphasis): #ff5b29 · Highlight wash: #f5ff80

1. **Hero**: #fafafa bg with dot-grid overlay. Eyebrow Geist Mono 14px uppercase/500 black. Headline Geist 80px/600 #ff5b29, -0.03em, faded echo word at 30% opacity. Body Geist 18px/400 #6c6c6c. Black filled pill + outlined pill side by side. Right: black line-art isometric diagram.
2. **Stats Banner**: #fafafa, 12px radius, 1px #000 border, `5px 5px 0px #000`. Three columns with hairline dividers. Numbers Geist Mono 48px/700 #ff5b29; labels Geist Mono 14px uppercase/400 black.
3. **Feature Card**: #fafafa, 12px radius, 1px #000 border, hard shadow. 24px padding. Outlined icon, Geist 20px/600 title, Geist 16px/400 #6c6c6c body.
4. **Integration Icon Grid**: 6-column wrapping grid, 12px gap. 56px circles, 1px #000 border.
5. **Enterprise Feature Row**: No card. 24px outlined icon, Geist 18px/600 title, Geist 16px/400 #6c6c6c body, 24px gaps.

## Color Discipline

Two-chromatic-punctuation rule: Signal Orange for voice/emphasis, Chartreuse for highlight/spotlight. Everything else achromatic. Orange never fills buttons or body text. Chartreuse never persists. Black does all structural work.

## CSS Custom Properties

```css
:root {
  --color-signal-orange: #ff5b29;
  --color-chartreuse-highlight: #f5ff80;
  --color-carbon-black: #000000;
  --color-paper-white: #fafafa;
  --color-graphite: #242424;
  --color-steel: #6c6c6c;
  --color-ash: #b3b3b3;
  --font-geist: 'Geist', ui-sans-serif, system-ui, sans-serif;
  --font-geist-mono: 'Geist Mono', ui-monospace, monospace;
  --text-display: 80px;
  --text-heading-lg: 52px;
  --radius-cards: 12px;
  --radius-buttons: 9999px;
  --radius-smallbuttons: 4px;
  --shadow-subtle: rgb(0, 0, 0) 5px 5px 0px 0px;
}
```
