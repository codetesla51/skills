# Linear — Style Reference
> midnight precision instrument

**Theme:** dark

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Linear's design system is a midnight command center built on near-black surfaces (#08090a) with paper-white type and one electric acid-lime accent (#e4f222) that functions as a functional flashlight — small, high-contrast, and used sparingly to signal action. Darkness is a substrate rather than a theme: crisp white text at tight tracking (-0.022em), weights in a low 400–510 band rather than bold, hairline-thin (0.5px) borders letting geometry do the work shadows usually would. Precision-machined components — 6px and 12px radii, compact 8–12px paddings, almost no ornament — letting the product UI (issue cards, kanban boards, AI agent panels) be the only visual texture.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Void | `#08090a` | `--color-void` | Page canvas, full-bleed backgrounds |
| Carbon | `#0f1011` | `--color-carbon` | Card surfaces, nav bars — one step above canvas |
| Obsidian | `#161718` | `--color-obsidian` | Elevated surfaces, deeper card panels |
| Graphite | `#23252a` | `--color-graphite` | Subtle borders, dividers, ghost button outlines |
| Smoke | `#383b3f` | `--color-smoke` | Higher-contrast hairline borders, section separators |
| Ash | `#62666d` | `--color-ash` | Muted body text, inactive icons, secondary metadata |
| Fog | `#8a8f98` | `--color-fog` | Tertiary text, placeholder copy, icon fills |
| Mist | `#d0d6e0` | `--color-mist` | Secondary headings, button text on dark surfaces |
| Bone | `#e5e5e6` | `--color-bone` | Near-white surface fills, high-contrast button text |
| Paper | `#ffffff` | `--color-paper` | Primary headings, hero type, max-contrast emphasis |
| Acid Lime | `#e4f222` | `--color-acid-lime` | Primary action buttons, active nav indicators — the one chromatic UI element |
| Pulse Green | `#27a644` | `--color-pulse-green` | Green outline accent for tags/dividers/focus. Supporting only, not status |
| Coral Red | `#eb5757` | `--color-coral-red` | Red wash for highlights/bands/emphasis. Supporting only |
| Signal Teal | `#02b8cc` | `--color-signal-teal` | Decorative accent, informational icon fills |
| Iris Violet | `#6366f1` | `--color-iris-violet` | Tag/badge fills — soft chromatic punctuation |
| Lavender | `#8b5cf6` | `--color-lavender` | Secondary tag fills, category indicators |

## Tokens — Typography

### Inter Variable — Primary UI and heading typeface (nav, body, headings, buttons, cards) · `--font-inter-variable`
- **Substitute:** Inter (variable), or system-ui as fallback
- **Weights:** 300, 400, 510, 590
- **Sizes:** 10, 11, 12, 13, 14, 15, 16, 17, 20, 24, 32, 48, 64, 72
- **Line height:** 1.0–2.75
- **Letter spacing:** -0.022em at 48–72px, -0.012em at 20–32px, -0.011em at 15px, -0.010em at 13–16px
- **OpenType features:** `"cv01" on, "ss03" on, "zero" on`

### Berkeley Mono — Code-adjacent UI text — issue IDs (ENG-2703), keyboard shortcuts, monospaced metadata · `--font-berkeley-mono`
- **Substitute:** JetBrains Mono, IBM Plex Mono, or ui-monospace
- **Weights:** 400
- **Sizes:** 12, 14
- **Line height:** 1.40–1.71
- **Letter spacing:** -0.013em

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| caption | — | — | 13px | 1.2 | — | `--text-caption` |
| body-sm | — | — | 15px | 1.6 | -0.165px | `--text-body-sm` |
| body-lg | — | — | 20px | 1.33 | -0.24px | `--text-body-lg` |
| subheading | — | — | 24px | 1.33 | -0.288px | `--text-subheading` |
| heading-sm | — | — | 32px | 1.13 | -0.704px | `--text-heading-sm` |
| heading | — | — | 48px | 1 | -1.056px | `--text-heading` |
| heading-lg | — | — | 64px | 1 | -1.408px | `--text-heading-lg` |
| display | — | — | 72px | 1 | -1.584px | `--text-display` |

### Type Scale Detail

Display 72px/510/lh 1.0/ls -0.022em · Hero 64px/510/1.0/-0.022em · Section 48px/510/1.0/-0.022em · Subheading 32px/400/1.13/-0.022em · Heading 24px/400/1.33/-0.012em · Body emphasis 20px/590/1.33/-0.012em · Body large 17px/590/1.6 · Body 16px/400/1.5 · Body small 15px/400/1.6/-0.011em · Caption 13px/400/1.2 · Label 12px/400/1.4 · Micro 10px/510/1.5

## Tokens — Spacing & Shapes

**Base unit:** 4px · **Density:** compact

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 4 | 4px | `--spacing-4` |
| 8 | 8px | `--spacing-8` |
| 12 | 12px | `--spacing-12` |
| 16 | 16px | `--spacing-16` |
| 20 | 20px | `--spacing-20` |
| 24 | 24px | `--spacing-24` |
| 28 | 28px | `--spacing-28` |
| 32 | 32px | `--spacing-32` |
| 36 | 36px | `--spacing-36` |
| 40 | 40px | `--spacing-40` |
| 48 | 48px | `--spacing-48` |
| 56 | 56px | `--spacing-56` |
| 64 | 64px | `--spacing-64` |
| 80 | 80px | `--spacing-80` |
| 96 | 96px | `--spacing-96` |
| 128 | 128px | `--spacing-128` |

### Border Radius

| Element | Value |
|---------|-------|
| cards | 12px |
| pills | 9999px |
| small | 2px |
| badges | 4px |
| inputs | 6px |
| buttons | 6px |

### Shadows

| Name | Value | Token |
|------|-------|-------|
| sm | `rgba(0, 0, 0, 0.4) 0px 2px 4px 0px` | `--shadow-sm` |
| md | `rgba(0, 0, 0, 0.2) 0px 0px 12px 0px inset` | `--shadow-md` |
| subtle | `rgb(35, 37, 42) 0px 0px 0px 1px inset` | `--shadow-subtle` |
| subtle-2 | `rgba(0, 0, 0, 0.2) 0px 0px 0px 1px` | `--shadow-subtle-2` |
| xl | `rgba(8, 9, 10, 0.6) 0px 4px 32px 0px` | `--shadow-xl` |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 96px
- **Card padding:** 24px
- **Element gap:** 8px

## Components

### Primary Action Button (Acid Lime)
Background #e4f222, text #08090a, 6px radius, 10px 16px padding, Inter 14px/510, -0.011em. The sole filled chromatic element — every other button is neutral.

### Nav Text Button
Transparent bg, #d0d6e0 text, 8px 12px padding, Inter 13px/400. No border, no fill — pure typographic nav, underline on hover.

### Pill Button
Background rgba(255,255,255,0.05), text #d0d6e0, 9999px radius, 4px 12px padding, Inter 12–13px/400. Tag chips, status pills, compact triggers.

### Ghost / Outline Button
Transparent bg, 1px #23252a border, #d0d6e0 text, 6px radius, 8px 12px padding, Inter 13px/400. Secondary actions.

### Sign-up Button (Rounded Pill, Neutral)
White bg (#ffffff), #08090a text, 9999px radius, 8px 16px padding, Inter 13px/510. White pill on dark nav — second highest contrast after the acid-lime CTA.

### Card (Product Screenshot Frame)
Background #0f1011, 12px radius, inset 1px #23252a border, 24px padding. Hairline inner border defines the edge — no outer shadow, no glow.

### Card (Subtle)
Background rgba(255,255,255,0.02), 6px radius, `rgba(0,0,0,0.4) 0 2px 4px` shadow, 8px padding. Barely separates from canvas.

### Text Input
Background rgba(255,255,255,0.02), 1px rgba(255,255,255,0.08) border, #d0d6e0 text, 6px radius, 12px 14px padding, Inter 14px/400. Focus: border brightens to #d0d6e0.

### Badge / Status Tag
Background rgba(255,255,255,0.05), #8a8f98 text, 4px radius, 0px 6px padding, Inter 12px/400. Color-coded variants: Pulse Green, Coral Red, Iris Violet, Lavender fills.

### Logo Mark
Wordmark + geometric glyph, Inter 16px/510, #ffffff. Glyph as inline SVG in white.

### Logo Bar (Customer Strip)
Neutral grey logos (#8a8f98–#d0d6e0), 48–64px gaps, no card backgrounds.

### Hero Gradient Floor
Linear gradient rgb(8,9,10) at 10% → rgb(208,214,224) at 100% — subtle light wash grounding the floating product UI against the void.

## Do's and Don'ts

### Do
- Inter Variable with 'cv01', 'ss03', 'zero' on — alternate glyphs define the typographic identity
- #e4f222 exclusively for the single primary action per view — never decoration, never secondary buttons
- Body 16px/400, lh 1.5; 17px+/590 reserved for body emphasis blocks
- -0.022em tracking at 48px+ — non-negotiable for display
- Cards 12px, buttons 6px, pills 9999px — the entire radius vocabulary
- 0.5px hairlines (#23252a/#383b3f) over shadows for separation
- 96px section gaps, 8px element gaps — the 8/12/24/96 ladder

### Don't
- Don't use bold weights (700+) — scale caps at 590
- Don't decorate buttons/cards/text with gradients — hero floor only
- Don't add chromatic accents as actions — acid-lime button is the only chromatic UI
- Don't use large radii (16px+) on cards/panels — 12px max
- Don't shadow-separate cards — hairlines (#23252a) + inset shadows
- Don't use chromatic body text — all body in #d0d6e0/#8a8f98/#62666d grey scale
- Don't use Berkeley Mono for headings/marketing — issue IDs, shortcuts, metadata only

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Void | `#08090a` | Page canvas, full-bleed backgrounds |
| 1 | Carbon | `#0f1011` | Cards, screenshot frames, nav containers |
| 2 | Obsidian | `#161718` | Elevated panels, deeper nested surfaces |
| 3 | Slate | `#23252a` | Interactive tints, ghost fills, border-adjacent backgrounds |

## Elevation

Hairline borders (0.5px #23252a, 1px inset #23252a) + subtle dark drop shadows (`rgba(0,0,0,0.4) 0 2px 4px`), not layered stacks. Hierarchy from surface progression (#08090a → #0f1011 → #161718 → #23252a) + border definition. The acid-lime CTA uses an inset shadow stack — the only chrome element with a real shadow.

## Imagery

Product-screenshot-first: hero and sections are real app UI at full fidelity — issue cards, kanban boards, AI panels, command palettes — inside hairline-bordered frames. No stock, no lifestyle, no abstract illustration. Customer logos neutral grey (#8a8f98), uniform size. Minimal line-art SVG icons, single-color grey scale. Hero screenshot floats on a subtle dark-to-light gradient floor. Every visual is a functional artifact of the product.

## Layout

Max-width ~1200px centered, full-bleed dark backgrounds to viewport edges. Hero: left-aligned oversized headline (64–72px) + right-aligned link CTA, then a large product screenshot bleeding slightly past max-width. Sections alternate text-left/image-right 2-column and full-width showcase bands, 96px gaps. Customer logos single horizontal row. Never 3-column grids or masonry — low density, one focal point per screen. Fixed top bar, left logo, right links, no sidebar.

## Agent Prompt Guide

text heading #ffffff · body #d0d6e0 · muted #8a8f98 · bg #08090a · card #0f1011 · border #23252a · accent #e4f222

1. **Hero headline**: full-bleed #08090a. 64px Inter Variable 510 #ffffff, -0.022em, lh 1.0. Subtext 16px/400 #8a8f98. No button — secondary link #d0d6e0 with arrow glyph.
2. **Screenshot card**: #0f1011 bg, 12px radius, inset 1px #23252a border, 24px padding. Simulated app UI at full opacity. No outer shadow.
3. **Acid-lime CTA**: #e4f222 bg, #08090a text, 6px radius, 10px 16px, Inter 14px/510, -0.011em. One per view.
4. **Nav bar**: #08090a, 16px horizontal padding, 1200px centered. Logo #ffffff 16px/510 left. Links #d0d6e0 13px/400, 8px gaps. Right white pill sign-up (#ffffff bg, #08090a text, 9999px, 8px 16px).
5. **Status badges**: horizontal flex, 8px gap. rgba(255,255,255,0.05) bg, #8a8f98 text, 4px radius, 0px 6px, Inter 12px/400. Variants: #27a644 success, #eb5757 error, #6366f1 tags.

## CSS Custom Properties

```css
:root {
  --color-void: #08090a;
  --color-carbon: #0f1011;
  --color-obsidian: #161718;
  --color-graphite: #23252a;
  --color-smoke: #383b3f;
  --color-ash: #62666d;
  --color-fog: #8a8f98;
  --color-mist: #d0d6e0;
  --color-bone: #e5e5e6;
  --color-paper: #ffffff;
  --color-acid-lime: #e4f222;
  --color-pulse-green: #27a644;
  --color-coral-red: #eb5757;
  --color-signal-teal: #02b8cc;
  --color-iris-violet: #6366f1;
  --color-lavender: #8b5cf6;
  --font-inter-variable: 'Inter Variable', ui-sans-serif, system-ui, sans-serif;
  --font-berkeley-mono: 'Berkeley Mono', ui-monospace, monospace;
  --text-display: 72px;
  --text-heading-lg: 64px;
  --text-heading: 48px;
  --radius-cards: 12px;
  --radius-buttons: 6px;
  --radius-pills: 9999px;
  --radius-badges: 4px;
  --page-max-width: 1200px;
  --section-gap: 96px;
}
```
