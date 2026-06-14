# Changelog

All notable changes to the Scanlines theme are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed (post-push CI follow-up)
- Hugo 0.158+ deprecation warnings that failed the first CI run: Hugo 0.158
  deprecated every `LanguageCode` spelling, but the replacement
  `.Language.Locale` hard-errors on Hugo < 0.158. Templates now read the
  language through a version-branched `partials/site-language.html`, and the
  exampleSite/docs use the `locale` config key (with a `languageCode` note for
  older Hugo).
- CI now builds against a version matrix — the theme's `min_version` (0.146.7)
  and `latest` — so both ends of the supported range stay guarded.

### Added
- **JSON-LD structured data** — `BlogPosting` on posts, `WebSite` on the home
  page, and a `Person` node in profile mode (`partials/schema.html`).
- **`contentSection` option** (`params.scanlines.contentSection`) so the
  homepage, archive, and 404 work with a renamed content directory instead of a
  hardcoded `posts`.
- **Categories support** — categories now render on posts, and taxonomy term
  pages are labelled by their own taxonomy (no longer hardcoded to "tags").
- **Markdown render hooks** (`layouts/_markup/`) — lazy-loaded images, external
  links that open in a new tab (no visual marker), and hover-revealed heading
  permalinks.
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
- **Subdirectory baseURL** — the home/branding link, favicon, and profile
  buttons/avatar now resolve under a subpath `baseURL` (e.g. GitHub Pages
  project sites) instead of escaping to the host root.
- **Keyboard-operable disclosures** — the collapsible TOC is now a native
  `<details>`/`<summary>`, and the mobile-nav toggle is a focusable control with
  a visible focus ring; collapsed nav links no longer stay in the tab order.
  (Previously both relied on a `display:none` checkbox that no keyboard could
  reach.)
- **Paginated list pages** now self-canonicalize: `/posts/page/2/` and taxonomy
  term pages point `rel=canonical`/`og:url` at their own URL instead of page 1,
  so posts only linked from deeper pages stay crawlable.
- **Pagination controls are styled again** — the pager now uses a theme partial
  with the terminal `<< PREV` / `PAGE n / m` / `NEXT >>` styling, replacing
  Hugo's embedded `.page-item`/`.page-link` markup the CSS never targeted.
- **CRT master toggle** — `effects.enabled = false` now also removes the screen
  curvature/vignette (it previously left `crt-vignette-enabled` on the body), and
  `effects.vignette = false` removes the second, hardcoded vignette layer too
  (no more two stacked vignettes).
- **Reduced motion** — the opt-in screen flicker now stops under
  `prefers-reduced-motion`, and `flickerIntensity` is validated and clamped to
  `≤ 1` so a mis-set value can't produce a high-amplitude flash.
- **Printing** — printed pages remap to ink-on-paper (legible headings, code,
  tables; glow/curvature shadows and the status line removed) instead of pale
  amber on near-black.
- **Line numbers** — table-mode code blocks no longer wrap, so the line-number
  column stays aligned with the code beside it.
- **Homepage share cards** — `og:title`/`twitter:title` use the site name on the
  home page instead of the literal "Home".
- **Meta description** — posts without a front-matter `description` now fall back
  to the page summary (matching the JSON-LD) instead of the site description.
- **JSON-LD** — non-post pages (e.g. About) now emit `WebPage` rather than a
  dateless `BlogPosting`.
- **Dateless pages** — list views guard the date, so a page without one no longer
  prints `0001-01-01`.
- **Blog-mode "Posts" menu** — the auto-hide of the posts link now also works
  under a subdirectory `baseURL`.
- **Status line** is now `aria-hidden` (it duplicated page content, created a
  second `contentinfo` landmark, and read the cursor `_` aloud as "underscore").

### Documentation
- README Quick Start and the Syntax Highlighting section now flag the required
  `[markup.highlight] noClasses = false`; without it Hugo injects its own
  (monokai) inline colors and the theme's code styling never applies.

### Changed
- **Links are standard underlined hyperlinks** — content and footer credit links
  now underline, and the external-link `↗` marker is gone. External links still
  open in a new tab (`rel="noopener noreferrer"`), just without the visual marker.
  Tag chips stay lowercase (`#tag`); category chips keep their case.
- **Custom `contentSection` gets the full post list** — the rich listing
  (reading time, tag chips, POSTS heading) moved to `_default/section.html`, so a
  renamed posts directory keeps it instead of falling back to a bare list.
- **Taxonomy links use `.GetTerms`** instead of hardcoded `/tags/` + `urlize`,
  so they honor renamed taxonomies, custom permalinks, and `disablePathToLower`.
- **Translatable strings** — `MENU`, `HOME`, the pager, and the taxonomy
  "No … found" message now route through `i18n` (with English fallbacks); the
  status line shows the taxonomy's own name (e.g. `CATEGORIES`) instead of always
  "TAGS".
- **WOFF2-only fonts** — dropped the `.ttf` fallbacks (~378 KB) no supported
  browser downloads.
- Open Graph/Twitter cards now use `summary_large_image` when an image is
  available and add `og:locale`, `og:image:alt`, and `article:author`/`section`.
- Removed the obsolete `X-UA-Compatible` meta tag and trimmed the Hugo version
  from the `generator` meta.
- **Minimum Hugo version is now 0.146.0** — the markdown render hooks live in
  `layouts/_markup/`, which requires the Hugo 0.146+ template system.
- **TOC defaults are now section-aware**: posts show a TOC by default; other
  pages opt in with `toc: true`. Previously any page with headings got one.
- Root pages (e.g. `/about/`) no longer render a zero date (`0001-01-01`) or
  prev/next post navigation chaining to unrelated sibling pages.
- `og:locale` now emits the correct `language_TERRITORY` casing (`en_US`).
- Removed the placeholder `static/css/custom.css` the theme shipped — it caused
  an extra render-blocking request on every downstream site. Sites create their
  own as documented.
- Removed dead `layouts/page/` templates that the Hugo 0.146 template system no
  longer resolves; `layouts/_default/` was already handling those pages.
- Added `go.mod` (proper Hugo Module path) and theme-gallery screenshots at the
  required dimensions (`images/screenshot.png` 1500×1000, `images/tn.png`
  900×600).
