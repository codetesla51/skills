# Earlydog — Style Reference
> Bauhaus poster pinned to a cloud architect's corkboard — cream paper, primary-color shapes, oversized geometric type.

**Theme:** light

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Earlydog operates as a Bauhaus design lab transplanted into DevOps — warm cream paper backgrounds, near-black typography, one vivid blue accent, and geometric illustrations built from primary-color primitives (circles, squares, checkerboards, starbursts, triangles). The display face (degular-display) sets oversized 52–116px headlines with positive letter-spacing, an unusual choice that gives the type geometric breathing room rather than the tight editorial tension most display fonts chase. Body copy stays at 18px in a humanist sans (usual), keeping reading temperature warm against the eggshell canvas. Components are intentionally sparse: pill-shaped outlined buttons, ghost links with play-triangle markers, and generous 96px section gaps that let the geometric artwork breathe. The functional palette is restricted to three colors — cream, ink, blue — while illustrations carry the full primary-color spectrum as decorative punctuation.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Cream Paper | `#fff9f0` | `--color-cream-paper` | Page canvas, card surfaces, button fills — warm off-white gives the entire interface a paper-like, print-graphic feel that warms the cool blue accent |
| Midnight Ink | `#000609` | `--color-midnight-ink` | Primary text, heading strokes, hairline borders, outlined button frames, logo mark — near-black with a barely-perceptible blue tint keeps it from feeling dead |
| Signal Blue | `#0a65db` | `--color-signal-blue` | Accent headings, icon strokes, active nav emphasis, illustration accent shapes — the single chromatic functional color, used sparingly to mark emphasis and brand voice |
| Ember Red | `#ee4623` | `--color-ember-red` | Illustration accent — primary-color punctuation in geometric compositions, starbursts, circular forms, and triangle fills |
| Saffron Yellow | `#ffd23f` | `--color-saffron-yellow` | Illustration accent — warm primary used in geometric blocks, semicircles, and composition fills alongside Ember Red and Signal Blue |
| Blush Pink | `#f4c6c6` | `--color-blush-pink` | Illustration accent — softens the primary-color palette in geometric compositions, used in rectangles and overlapping shapes |

## Tokens — Typography

### degular-display — Display headlines for all section headings and the hero title. The single weight 700 and positive letter-spacing (0.009–0.019em) create a wide-set, geometric presence — letterspacing INCREASES with size, the opposite of conventional display type. · `--font-degular-display`
- **Substitute:** Archivo Black, Space Grotesk, or any wide geometric grotesque
- **Weights:** 700
- **Sizes:** 52px, 80px, 116px
- **Line height:** 1.03–1.23
- **Letter spacing:** 0.009em at 52px, 0.013em at 80px, 0.019em at 116px
- **Role:** Display headlines for all section headings and the hero title.

### usual — Body copy, navigation, buttons, links, footer, card descriptions. The 1.78–1.82 line-height is notably generous for sans-serif body text — typical SaaS body sits at 1.5–1.6, but Earlydog's open leading reinforces the spacious layout. Weight 700 is used sparingly for inline emphasis. · `--font-usual`
- **Substitute:** Inter, IBM Plex Sans, or DM Sans
- **Weights:** 400, 700
- **Sizes:** 16px, 18px, 22px
- **Line height:** 1.78–1.82
- **Letter spacing:** normal
- **Role:** Body copy, navigation, buttons, links, footer, card descriptions.

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| caption | — | — | 16px | 1.78 | 0px | `--text-caption` |
| body | — | — | 18px | 1.82 | 0px | `--text-body` |
| subheading | — | — | 22px | 1.82 | 0px | `--text-subheading` |
| heading-sm | — | — | 52px | 1.23 | 0.47px | `--text-heading-sm` |
| heading | — | — | 80px | 1.1 | 1.04px | `--text-heading` |
| display | — | — | 116px | 1.03 | 2.2px | `--text-display` |

## Tokens — Spacing & Shapes

**Base unit:** 4px · **Density:** spacious

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 16 | 16px | `--spacing-16` |
| 20 | 20px | `--spacing-20` |
| 24 | 24px | `--spacing-24` |
| 32 | 32px | `--spacing-32` |
| 40 | 40px | `--spacing-40` |
| 44 | 44px | `--spacing-44` |
| 48 | 48px | `--spacing-48` |
| 96 | 96px | `--spacing-96` |
| 104 | 104px | `--spacing-104` |
| 120 | 120px | `--spacing-120` |
| 128 | 128px | `--spacing-128` |

### Border Radius

| Element | Value |
|---------|-------|
| cards | 0px |
| buttons | 9999px |
| illustrations | 0px |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 96px
- **Card padding:** 32px
- **Element gap:** 16-32px

## Components

### Outlined Pill Button
Fully rounded pill (border-radius: 9999px), 1px solid Midnight Ink (#000609) border, Cream Paper (#fff9f0) fill, text in usual 16px weight 700 Midnight Ink. Horizontal padding 30px, vertical padding 14–20px. No fill, no shadow — the border IS the button.

### Ghost Link with Triangle
Plain Midnight Ink text in usual 16px weight 700, followed by a small right-pointing triangle marker (▸) in Midnight Ink. No underline, no background. Used for header CTA and inline section links.

### Hamburger Menu Icon
Two horizontal black bars (Midnight Ink) stacked with 2px gap. Sits at 44px from top, paired with the vertical EARLYDOG wordmark below it.

### Vertical Wordmark
EARLYDOG rotated 90° counter-clockwise, set in usual 16px weight 700 Midnight Ink. Fixed brand signature in the left margin.

### Hero Display Heading
degular-display 80px weight 700, line-height 1.10, letter-spacing +1.04px. Two-tone: 'Your Cloud' in Midnight Ink, 'Ops Team' in Signal Blue. The blue second-line is the only chromatic text on the page.

### Body Paragraph Block
usual 18px weight 400 Midnight Ink, line-height 1.82, max-width ~480px.

### Section Heading (Sub-display)
degular-display 52px weight 700, line-height 1.23, letter-spacing +0.47px, Midnight Ink.

### Geometric Illustration Block
Square or near-square composition (~520px) built from Bauhaus primitives: solid color rectangles, circles, semicircles, triangles, checkerboard grids (8×8 black/cream), and thin-line starburst patterns. Palette: Ember Red, Saffron Yellow, Signal Blue, Blush Pink, Midnight Ink, Cream Paper. All shapes sharp 0px corners.

### Two-Column Feature Section
Two equal columns separated by 104px horizontal margin within max-width container. One column illustration, the other heading + body + pill button. 96px vertical spacing between sections. No card backgrounds, no dividers.

### Starburst Line Pattern
Thin (1px) Midnight Ink lines radiating from a single point at 15° intervals. Overlaid on cream or blue squares within compositions.

### Checkerboard Grid
8×8 alternating Midnight Ink and Cream Paper squares. No border, sharp 0px edges.

## Do's and Don'ts

### Do
- Use degular-display 700 for all headings
- Set display headings at 52, 80, or 116px with corresponding positive letter-spacing (0.009–0.019em)
- Use border-radius: 9999px for all buttons and tags
- Build illustrations from Bauhaus primitives, all sharp 0px corners
- Restrict the UI palette to three colors (#fff9f0, #000609, #0a65db)
- Maintain 96px vertical gaps between major sections
- Pair body text at 18px/1.82 with max-width ~480px

### Don't
- Don't use rounded corners on illustrations, cards, or decorative shapes
- Don't use filled colored buttons — all interactive elements are outlined pills
- Don't apply negative letter-spacing to display headings
- Don't introduce more than one chromatic functional color
- Don't use body text below 16px or line-height tighter than 1.78
- Don't add drop shadows, gradients, or glows
- Don't use photographic imagery or realistic illustrations

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 1 | Cream Canvas | `#fff9f0` | Page background across all sections |
| 2 | Signal Blue Panel | `#0a65db` | Accent surface inside artwork, not page chrome |

## Elevation

Zero elevation. Flat — surfaces defined by color contrast and geometric composition, not shadows. Depth implied through overlapping geometric forms within illustrations.

## Imagery

Zero photography. Flat geometric illustrations: Bauhaus compositions of circles, squares, triangles, checkerboards, starbursts, semicircles in Ember Red, Saffron Yellow, Signal Blue, Blush Pink, Midnight Ink, Cream Paper. Square blocks (~500–550px) as compositional counterparts to text columns. All shapes sharp corners.

## Layout

Two-column alternating layout on full-bleed cream canvas. Left rail holds fixed vertical wordmark and hamburger menu; content flows in ~1200px centered column. Hero text-left/illustration-right with two-tone display heading. Subsequent sections alternate. Minimal navigation: hamburger (left rail) + single ghost link CTA top-right.

## Agent Prompt Guide

**Quick Color Reference**
- background: #fff9f0 (Cream Paper)
- text: #000609 (Midnight Ink)
- border: #000609 (Midnight Ink, 1px)
- accent: #0a65db (Signal Blue)

**Example Component Prompts**

1. **Hero Section**: Cream Paper (#fff9f0) full-bleed. Two-column: left display heading degular-display 80px/700/1.10/+1.04px — first line Midnight Ink, second line Signal Blue; body usual 18px/400/1.82, max-width 480px. Right: 520px square geometric illustration from Bauhaus primitives in Ember Red, Saffron Yellow, Signal Blue, Blush Pink, Midnight Ink on Cream Paper. All 0px radius.
2. **Outlined Pill Button**: 9999px radius, 1px Midnight Ink border, Cream Paper fill, usual 16px/700, padding 14px × 30px. No shadow, no gradient.
3. **Section Heading + Body**: degular-display 52px/700/1.23/+0.47px Midnight Ink; body usual 18px/400/1.82 max-width 480px; heading-to-body 24px; section-to-section 96px.
4. **Geometric Illustration Block**: 520×520px on Cream Paper: Signal Blue square with white circle + black dot (eye motif); Ember Red circle; 8×8 checkerboard; starburst of 1px lines; triangles/semicircles in Saffron, Blush, Blue. Flat, no shadows, 0px radius.
5. **Ghost Link with Triangle Marker**: usual 16px/700 Midnight Ink + ▸ triangle. No underline, no background.

## CSS Custom Properties

```css
:root {
  --color-cream-paper: #fff9f0;
  --color-midnight-ink: #000609;
  --color-signal-blue: #0a65db;
  --color-ember-red: #ee4623;
  --color-saffron-yellow: #ffd23f;
  --color-blush-pink: #f4c6c6;
  --font-degular-display: 'degular-display', ui-sans-serif, system-ui, sans-serif;
  --font-usual: 'usual', ui-sans-serif, system-ui, sans-serif;
  --text-body: 18px;
  --text-heading-sm: 52px;
  --text-heading: 80px;
  --text-display: 116px;
  --spacing-96: 96px;
  --spacing-104: 104px;
  --page-max-width: 1200px;
  --section-gap: 96px;
  --radius-full: 9999px;
  --radius-cards: 0px;
  --radius-buttons: 9999px;
  --radius-illustrations: 0px;
}
```
