# Changelog

All notable changes to the Scanlines theme are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **JSON-LD structured data** — `BlogPosting` on posts, `WebSite` on the home
  page, and a `Person` node in profile mode (`partials/schema.html`).
- **`contentSection` option** (`params.scanlines.contentSection`) so the
  homepage, archive, and 404 work with a renamed content directory instead of a
  hardcoded `posts`.
- **Categories support** — categories now render on posts, and taxonomy term
  pages are labelled by their own taxonomy (no longer hardcoded to "tags").
- **Markdown render hooks** (`layouts/_markup/`) — lazy-loaded images, external
  links that open safely in a new tab with a `↗` marker, and hover-revealed
  heading permalinks.
- **Internationalization** — user-facing strings now go through Hugo's `i18n`
  system with English fallbacks; ships `i18n/en.toml` as a translation
  template.
- **WOFF2 fonts** — Glass TTY VT220 (−93%) and Fira Code (−65%) now ship as
  WOFF2 with a TTF fallback.
- Site-wide default Open Graph image via `params.scanlines.ogImage`.
- Documented z-index scale and scheme-aware syntax highlight colors.
- GitHub Actions workflow that builds the exampleSite and fails on warnings;
  `.editorconfig`.

### Fixed
- **Pagination** — list and posts templates paginated a different collection
  than they rendered, so every page showed the full list. They now render the
  paginated set.
- **`asciiScale` build crash** — a non-numeric value (e.g. `asciiScale =
  "large"`) is now validated and ignored instead of aborting the build.
- **Heading hierarchy** — the blog homepage now has an `h1` and `h2` post
  titles (was `h3` with no `h1`).
- **High-contrast mode** now overrides `--color-accent`, so focus rings and
  accents meet contrast in that mode.
- **`showBox` default** — unset now matches the documented default (boxed
  header); template logic corrected.
- Distinctive keyboard focus indicators on the nav and TOC toggle controls,
  plus a `button:focus` fallback for browsers without `:focus-visible`.

### Changed
- Open Graph/Twitter cards now use `summary_large_image` when an image is
  available and add `og:locale`, `og:image:alt`, and `article:author`/`section`.
- Removed the obsolete `X-UA-Compatible` meta tag and trimmed the Hugo version
  from the `generator` meta.
