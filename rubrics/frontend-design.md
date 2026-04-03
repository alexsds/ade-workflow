# Frontend Design Rubric

## Applies To

Features involving UI components, pages, layouts, visual elements, or any user-facing interface work.

## Criteria

### Design Quality (weight: high)

Threshold: 7/10

The UI should feel like a coherent whole with a unified mood and identity — not separate components strung together. Colors, typography, layout, and imagery should work together toward a single vision.

Evaluate: Does the page feel like one designer built it? Is there a consistent visual language? Do all elements contribute to the same mood?

### Originality (weight: high)

Threshold: 7/10

Every design choice should be deliberate. AI tends to default to the same purple-and-white gradient pattern for most UIs — this is "AI slop" and must be penalized.

Penalize: Purple/white gradients, generic card grids, stock hero sections, default shadow/border-radius patterns, template-looking layouts.

Reward: Distinctive color palettes, unexpected but functional layouts, personality in micro-interactions, creative typography choices.

### Craft (weight: medium)

Threshold: 6/10

Technical execution of visual design. The minor details that separate polished work from rough drafts.

Evaluate: Typography hierarchy (clear h1 > h2 > body), consistent spacing (using a spacing scale), color harmony (complementary or analogous palette), proper contrast ratios (WCAG AA minimum), responsive behavior at common breakpoints.

### Functionality (weight: medium)

Threshold: 6/10

Each UI component serves a clear purpose and enhances the user experience. Interactions are intuitive and feedback is immediate.

Evaluate: No dead buttons or broken links. Forms validate inline. Loading states appear when expected. Error states are informative. Navigation is predictable.

## Scoring Guide

- 9-10: Exceptional — exceeds expectations, distinctive and polished
- 7-8: Solid — meets standards, cohesive and deliberate
- 5-6: Acceptable — functional but generic or rough
- 3-4: Below standards — inconsistent, template-looking, or confusing
- 1-2: Failing — broken, incoherent, or unusable

## Calibration Examples

These few-shot examples help calibrate consistent scoring:

**Design Quality — Score 8:**
A dashboard with a warm amber/slate color palette. All cards use the same border style, typography scale, and spacing rhythm. The sidebar, header, and content area feel like parts of the same product. Minor: the footer feels slightly detached.

**Design Quality — Score 5:**
A page where the hero section uses a blue gradient, the cards below use flat gray backgrounds, and the footer switches to dark mode. Each section works individually but they don't feel like the same app.

**Originality — Score 8:**
A task manager using an earth-tone palette with clay-colored cards, hand-drawn-style icons, and a warm paper texture background. Feels intentional and distinctive — not something you'd mistake for a template.

**Originality — Score 4:**
Purple-to-blue gradient header, white card grid with rounded corners and subtle shadows, sans-serif font. This is the default Claude/AI visual pattern and should be penalized.

**Craft — Score 8:**
Clear h1/h2/body hierarchy, consistent 4px spacing scale, AA contrast on all text, smooth transitions on hover states, layout holds at 375px/768px/1280px breakpoints.

**Craft — Score 5:**
Font sizes vary inconsistently, some elements have 8px padding while others use 16px, contrast fails on light gray text, layout breaks on mobile.
