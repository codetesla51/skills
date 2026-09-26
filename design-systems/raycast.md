# Raycast — Style Reference
> Midnight command center, coral neon

**Theme:** dark

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Raycast reads as a dark power-tool cockpit: almost-black canvas (#040506) with barely-visible elevation steps, one warm coral accent (#ff6363) for brand identity, quiet white/gray Inter typography. Components defined by hairline borders, inset highlight strokes, and the 'keyboard key' inner-shadow treatment — cards feel pressed and tactile, not floating. 98% achromatic; coral only in logo, hero artwork, AI badge, warm-tinted surfaces. Floating glass-blur nav; neutral light-gray buttons, not chromatic CTAs. Hero abandons the system with large red/blue gradient geometry, then the page returns to austere dark — contrast through atmosphere.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Void Black | `#040506` | `--color-void-black` | Page canvas, dominant background |
| Ink | `#07080a` | `--color-ink` | Card surfaces, elevated panels, image backgrounds |
| Obsidian | `#111214` | `--color-obsidian` | Subtle tint, pressed states, input wells |
| Graphite | `#1b1c1e` | `--color-graphite` | Neutral form states, badge text, quiet feedback |
| Smoke | `#6a6b6c` | `--color-smoke` | Secondary body text, muted labels |
| Ash | `#9c9c9d` | `--color-ash` | Light text on dark, inverse labels, captions |
| Mist | `#e6e6e6` | `--color-mist` | Light neutral action fill for buttons on dark |
| Iron | `#454647` | `--color-iron` | Button text on light fills, mid-gray borders |
| Slate | `#2f3031` | `--color-slate` | Dark button borders, ghost button labels |
| Pure White | `#ffffff` | `--color-pure-white` | Headings, high-emphasis text |
| Coral Pulse | `#ff6363` | `--color-coral-pulse` | Brand accent — logo, AI badge, hero art, warm punctuation |
| Ember Hush | `#452324` | `--color-ember-hush` | Warm-tinted card backgrounds, accent surface tints |
| Electric Sky | `#63a1ff` | `--color-electric-sky` | Hero illustration mid-tone only, not UI |
| Cobalt Edge | `#143ca3` | `--color-cobalt-edge` | Hero illustration stroke, gradient anchor |
| Deep Space | `#02193b` | `--color-deep-space` | Hero illustration fill — not a UI token |
| Info Blue | `#56c2ff` | `--color-info-blue` | Blue wash highlights — supporting accent, not status |
| Success Green | `#59d499` | `--color-success-green` | Green wash highlights — supporting accent, not status |

## Tokens — Typography

### Inter — Primary interface typeface. Body 16px/400; nav/labels 13–14px/500; subheadings 18–22px/400; sections 32–56px (400–600); display 64px/600. Weight 400 at the 56px hero headline is the signature anti-convention — regular weight, size does the work. · `--font-inter`
- **Substitute:** system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif
- **Weights:** 400, 500, 600
- **Sizes:** 11–64px
- **Line height:** 0.91–1.71
- **Letter spacing:** 0.0040em at 56px, 0.0100em at 20px, 0.0140em at 14px, 0.0080em at 13px, 0.0730em at 11px uppercase eyebrow
- **OpenType features:** `'calt', 'kern', 'liga', 'ss03'`

### GeistMono — Monospace for versions, micro-labels, terminal text, 10px uppercase eyebrows, footer metadata. Substitutes: JetBrains Mono, Menlo, Courier · `--font-geistmono`
- **Weights:** 300, 400, 500 · **Sizes:** 10px, 12px, 14px

### SF Pro Text — Icon glyphs and numeric stat callouts 24–32px/500. macOS native feel · `--font-sf-pro-text`
- **Weights:** 500, 700 · **Sizes:** 16px, 24px, 32px

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| eyebrow | — | — | 11px | 0.91 | 0.8px | `--text-eyebrow` |
| body | — | — | 16px | 1.15 | 0px | `--text-body` |
| body-lg | — | — | 18px | 1.15 | 0px | `--text-body-lg` |
| subheading | — | — | 20px | 1.2 | 0.2px | `--text-subheading` |
| heading-sm | — | — | 24px | 1.15 | 0px | `--text-heading-sm` |
| heading | — | — | 32px | 1.15 | 0px | `--text-heading` |
| heading-lg | — | — | 56px | 1.17 | 0.22px | `--text-heading-lg` |
| display | — | — | 64px | 1.1 | 0px | `--text-display` |

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
| 48 | 48px | `--spacing-48` |
| 56 | 56px | `--spacing-56` |
| 64 | 64px | `--spacing-64` |
| 80 | 80px | `--spacing-80` |
| 96 | 96px | `--spacing-96` |
| 120 | 120px | `--spacing-120` |
| 224 | 224px | `--spacing-224` |

### Border Radius

| Element | Value |
|---------|-------|
| cards | 16px |
| pills | 9999px |
| badges | 6px |
| inputs | 8px |
| buttons | 8px |
| largeCards | 20px |
| iconContainers | 99999px |

### Shadows

Signature is the 'keyboard key' inset stack, not drop shadows:
`rgba(255,255,255,0.05) 0px 1px 0px 0px inset, rgba(255,255,255,0.25) 0px 0px 0px 1px, rgba(0,0,0,0.2) 0px -1px 0px 0px inset`

### Layout

- **Page max-width:** 1200px
- **Section gap:** 80-120px
- **Card padding:** 24px
- **Element gap:** 8-16px

## Components

### Glass Navigation Bar
Floating pill, backdrop-blur(48px), 1px #363739 border, 8px radius, transparent dark fill over #040506. Red diamond logo + white 13px/500 wordmark left; centered #9c9c9d 13–14px links; light-gray Download button right. ~8px/16px internal padding.

### Neutral Filled Button (Download CTA)
Mist (#e6e6e6) fill, Iron (#454647) 13–14px/500 text, 8px radius, 8px 12px padding. Optional small dark platform icon (15px). The only filled action surface — deliberately neutral.

### Ghost Nav Link
Transparent, Ash (#9c9c9d) 13–14px text, no border/padding. Hover → white.

### Feature Card with Key Shadow
16px radius, 24px padding. 'Keyboard key' stack: white 0.05 inset top highlight + white 0.25 outer 1px ring + black 0.2 inset bottom. Pressed, tactile — recessed key cap, not floating card. Transparent fill so canvas shows through.

### Edge-Highlight Card
16–20px radius, transparent fill, 1px #363739 border + inset highlight stack. Defined by edge, not surface.

### Inset Input Field
8px radius, rgba(255,255,255,0.05) fill, 8px 12px padding, white 16px/400 text. Recessed well. Ash placeholders.

### Badge Tag
Graphite (#1b1c1e) fill, white text, 6px radius, tight padding. Versions, 'beta' tags, categories. Compact, quiet.

### Circular Icon Container
99999px radius, 20px padding, subtle dark fill. 24–32px glyph inside. Dock-item feel for app/extension icons.

### Hero Gradient Banner
Full-bleed red/blue geometry: blue radial wash (rgba(4,63,150,0.7) → rgba(6,18,37,0.25)) + diagonal coral bars (40px+ blur). The one rule-breaking cinematic moment before the austere page below.

### Footer Meta Strip
Centered Geist Mono 12px/400 Ash row, pipe-separated: version, platform, install command. 8px gap below download buttons. Monospace signals technical metadata.

### App Window Mockup
12px outer frame, 16px command bar, 8px result items. 'Key' inner-shadow chrome. White text on #07080a, one Coral Pulse highlight on the active row.

## Do's and Don'ts

### Do
- #040506 sole page background
- Coral (#ff6363) only for logo, hero art, AI badge, warm-tinted surfaces
- 'Key' inset stack on all elevated cards and feature blocks
- Hero 56px/400 Inter, +0.22px tracking — regular weight is the signature
- Mist (#e6e6e6) + Iron (#454647) for all primary actions — no chromatic CTA
- 8px buttons/inputs/badges; 16–20px cards; 9999px pills; 99999px icon circles
- Footer metadata pipe-separated, Geist Mono 12px

### Don't
- Don't use chromatic action buttons — neutral Mist on dark
- Don't drop-shadow cards — inset key stack, not outer shadows
- Don't negative-track display — slightly positive (0.0040em at 56px), intentional
- Don't add light sections or alternating bands — dark throughout
- Don't use #ff6363 for body, links, or general icons — brand mark only
- Don't multi-accent one surface — monochrome + one coral
- Don't use SF Pro Text for body — icons and stat callouts only
- Don't break the 8px grid

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Canvas | `#040506` | Default page background |
| 1 | Card | `#07080a` | Elevated blocks, hero image backdrops |
| 2 | Recessed | `#111214` | Inputs, pressed wells |
| 3 | Badge | `#1b1c1e` | Tags, monogram tiles |
| 4 | Accent Tint | `#452324` | Coral-tinted brand-anchored sections |

## Elevation

Atmosphere and inset key stacks, not drop shadows — except the hero's gradient/blur cinematic composition and subtle lift on neutral download buttons.

## Imagery

Hero: massive abstract red/blue geometry (diagonal bars, radial glows) — motion-graphics title card. Below: in-context dark product screenshots (command bar, result lists, extension icons). No photography. Icons: SF Pro/system glyphs 16–24px/500 in Mist on dark. Product UI is the hero.

## Layout

1200px centered column; hero and atmospheric sections full-bleed. Floating glass pill nav over full-viewport hero (centered 56px/400 headline over red/blue gradient). Below: contained sections, 80–120px rhythm. 3-column compact tiles, 2-column wide features. Dark-on-dark bands with hairline dividers. Single floating glass bar nav; no sidebar.

## Agent Prompt Guide

text #ffffff · secondary #9c9c9d · muted #6a6b6c · bg #040506 · card #07080a · border #363739 · accent #ff6363 · action #e6e6e6 fill + #454647 text

1. **Glass nav**: floating pill, blur(48px), 1px #363739, 8px radius. Red diamond + white 13px/500 wordmark; centered #9c9c9d 13px links; Mist Download button (8px, 8px 12px) with platform icon.
2. **Hero**: full-bleed #040506. Centered 56px/400 white headline (+0.22px). 16px/400 #9c9c9d subhead, ~480px max. Red/blue gradient art behind. Two Mist buttons with icons; Geist Mono 12px footer line (`v1.104.21 | macOS 13+ | Install via homebrew`, #6a6b6c).
3. **Feature card**: 16px radius, transparent on #07080a, 24px padding, key shadow stack. 99999px icon circle (20px padding, 24px Mist glyph), 20px/500 white subhead, 16px/400 #9c9c9d body.
4. **Extension tile**: 8px radius, 8px padding, 1px #363739. Icon circle + 14px/500 white name + 12px/400 #6a6b6c category. 8px grid gaps.
5. **Download group**: two Mist buttons (13px/500 Iron, 8px, 8px 12px, platform icons), 8px gap. Geist Mono 12px version line below, centered.

## CSS Custom Properties

```css
:root {
  --color-void-black: #040506;
  --color-ink: #07080a;
  --color-obsidian: #111214;
  --color-graphite: #1b1c1e;
  --color-smoke: #6a6b6c;
  --color-ash: #9c9c9d;
  --color-mist: #e6e6e6;
  --color-iron: #454647;
  --color-slate: #2f3031;
  --color-pure-white: #ffffff;
  --color-coral-pulse: #ff6363;
  --color-ember-hush: #452324;
  --font-inter: 'Inter', ui-sans-serif, system-ui, sans-serif;
  --font-geistmono: 'GeistMono', ui-monospace, monospace;
  --text-heading-lg: 56px;
  --text-display: 64px;
  --radius-cards: 16px;
  --radius-buttons: 8px;
  --radius-pills: 9999px;
  --radius-iconcontainers: 99999px;
  --page-max-width: 1200px;
}
```
