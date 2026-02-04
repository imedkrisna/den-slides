# DEN Slides

A Quarto template extension for creating DEN-branded presentations in both HTML (Reveal.js) and PDF (Beamer) formats.

## Features

- **Branded title slide** with background image
- **Logo** in top-right corner (hidden on title and ending slides)
- **Brown accent line** before slide headings
- **Styled page numbers** in brown box (bottom-right)
- **Adaptive title sizing** for long titles (auto-adjusts font size)
- **Ending slide** with full-page branded background
- Consistent styling across HTML and PDF outputs

## Installation

### From GitHub

```bash
quarto add imedk/den-slides
```

### Local Installation

Clone this repository and copy the `_extensions` folder to your project.

## Usage

Create a new `.qmd` file with the following YAML header:

```yaml
---
title: "Your Presentation Title"
date: "4 February 2026"
date-format: "DD MMMM YYYY"
format:
  den-revealjs: default
  den-beamer: default
---
```

### Creating Slides

```markdown
## Slide Title

Your content here.

- Bullet point 1
- Bullet point 2

## Another Slide

| Column 1 | Column 2 |
|----------|----------|
| Data A   | Data B   |

## {.ending-slide background-image="end.png" background-size="cover"}

::: {.ending-slide}
:::
```

> **Note:** The ending slide requires both the `## {.ending-slide ...}` header (for HTML) and the `::: {.ending-slide} :::` div (for PDF) to work correctly in both formats.

### Rendering

```bash
# Render to HTML (Reveal.js)
quarto render presentation.qmd --to den-revealjs

# Render to PDF (Beamer)
quarto render presentation.qmd --to den-beamer

# Render both formats
quarto render presentation.qmd
```

## Customization

### Brand Colors

Edit `_extensions/den/revealjs.scss` to change colors:

```scss
$den-brown: #6A4A3C;  /* Primary accent color */
$den-dark:  #2B2B2B;  /* Text color */
$den-gray:  #F2F2F2;  /* Background accent */
$den-white: #FFFFFF;  /* White */
```

### Images

Replace the following images in `_extensions/den/`:

- `title.png` - Title slide background
- `end.png` - Ending slide background  
- `logo.png` - Logo displayed on content slides

## File Structure

```
den-slides/
├── _extensions/
│   └── den/
│       ├── _extension.yaml    # Extension configuration
│       ├── revealjs.scss      # HTML/Reveal.js styles
│       ├── beamer-header.tex  # PDF/Beamer LaTeX header
│       ├── ending-slide.lua   # Lua filter for ending slides
│       ├── title-detect.html  # JS for adaptive title sizing
│       ├── title.png          # Title slide background
│       ├── end.png            # Ending slide background
│       └── logo.png           # Logo image
├── template.qmd               # Example template
├── README.md
└── LICENSE
```

## Requirements

- [Quarto](https://quarto.org/) >= 1.4
- For PDF output: LaTeX distribution (e.g., TinyTeX, TeX Live)

## License

MIT License
