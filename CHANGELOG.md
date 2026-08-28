# Changelog

All notable changes to the Scanlines theme are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.5] - 2026-08-28

Accessibility, generated-markup isolation, and configuration-edge-case fixes following adversarial review.

### Fixed

- **Page-load blue flash on navigation and header links eliminated.** Removed blanket
  `transition: color` and `transition: background-color` rules from `body`, `a`, and
  header/nav elements. On initial page paint, browsers were transitioning link colors
  from the User-Agent default link color (`#0000ee` blue) to the theme's phosphor palette
  over 200ms.
- **Wide line-numbered code blocks scroll horizontally again.** A previous fix (`98e7e52`)
  stopped `.lntable` from inheriting the content table scroll wrapper, but in doing so
  removed the only scroll container for line-numbered blocks — causing wide code to be
  clipped by `body { overflow-x: hidden }` with no scrollbar at any level. Horizontal
  scrolling is now explicitly set on `.highlight > .chroma`, which covers both table and
  inline modes while anchoring the language badge.
- **Focus styling no longer renders anchor text invisible.** On `.terms-link`,
  `.post-nav-link`, and `.ascii-header-link`, child elements set their own color, which
  prevented reverse-video focus from changing the text color — resulting in `--color-fg`
  text on a `--color-fg` background (1.00:1 contrast). These links now use the accent
  focus ring. Additionally, combined `&:hover, &:focus` rules on `.article-content a`,
  `.btn`, `.social-list a`, and `.toc-nav a` now use `:not(:focus-visible)` so keyboard
  focus is not out-specified by hover styling.
- **Language badges no longer overlap the first line of code.** Reserved height on
  `.highlight pre` so line-numbered code tables and plain code blocks align with proper
  clearance below the absolute-positioned badge.
- **Goldmark structural `<hr>` suppressed in footnotes.** Goldmark emits a structural
  `<hr>` inside `.footnotes`, which rendered as the theme's full-width terminal divider
  stacked directly above the footnote section's border and header.
- **Footnote reference bracket styling restored.** Updated `.footnote-ref` and
  `.footnote-backref` selectors for Goldmark markup where classes are placed on the
  anchor rather than `<sup>`.
- **Task list bullet duplication fixed.** Suppressed default list bullet markers on items
  containing task list checkboxes via `:has(> input[type="checkbox"])`.
- **Content paragraph and list margin leakage into chrome prevented.** Scoped bare `p`
  and `li` margins under `:where(.article-content)` to maintain flat specificity and
  prevent margins from disrupting post list separators and other UI chrome.
- **Figure caption and overlay handling.** Hugo `<figure>` shortcode output (`<h4>`
  titles and `<p>` captions) renders inline with bracketed terminal styling (`[ Title — Caption ]`)
  without paragraph margin leaks, and the image scanline overlay is contained from covering
  caption text.
- **Ordered Table of Contents support.** Added `<ol>` and nested `<ol>` styling in `.toc-nav`
  matching `<ul>` for sites configuring `[markup.tableOfContents] ordered = true`.
- **Clickable Chroma line numbers.** Reset link styles for `.lnlinks`, `a.lnt`, and `a.ln`
  when `anchorLineNos = true` so line-number links remain dim gutter indicators instead
  of taking on content link underlines and hover glows.
- **Definition list glow in CRT mode.** Added `<dt>` and `<dd>` to phosphor text glow
  rules and `effects-disabled` resets.

## [1.0.4] - 2026-08-23

Gallery-readiness pass ahead of submitting the theme to themes.gohugo.io.

### Fixed

- **Heading-permalink anchors no longer leak a `#` into meta descriptions,
  JSON-LD, listing excerpts or the RSS feed.** The heading render hook appends
  an anchor whose link text is a literal `#`, and `plainify` keeps that text —
  so any auto-summary reaching past a post's first heading read
  "...A Section Heading# More body text...". Six call sites flattened the
  summary that way; only the RSS feed had been fixed. They now share
  `layouts/partials/page-summary.html`, which strips the anchors and collapses
  the block-level newlines that were splitting `content="..."` attributes
  across lines. Posts that set an explicit `description` were never affected,
  which is why the demo site never showed it.
- **Focus rings survive Windows High Contrast mode.** The reverse-video focus
  treatment is built from `background-color`, `color` and `box-shadow`; in
  forced-colors mode the first two are overridden with system colours and the
  third is forced to `none`, so an explicit `outline: none` left no focus
  indicator at all. Now a transparent 2px outline, which forced-colors repaints
  with the system highlight.
- **The four contrast ratios in the README's colour-scheme table were wrong.**
  Recomputed with the WCAG 2.x relative-luminance formula: amber 10.8:1 (was
  listed as 12.5), green 13.6 (14.8), blue 8.7 (7.7), white 13.9 (13.5). All
  four are AAA. The surrounding claim is also corrected — it described the
  palette, not what the theme renders, since the CRT overlays composite black
  over the page and cost real contrast at the edges and on narrow screens.
- The changelog's own note on syntax-comment contrast said 7.32:1 where the
  code comment it describes says 6.40:1. 6.40 is correct.
- The homepage post list fell back to `summary` then `description` and stopped,
  while section listings had a third tier. A post with neither key showed an
  excerpt on `/posts/` but not on `/`. Both archetypes ship an empty
  `description`, so that was the default path for a new post.
- Singly-tagged term pages read "1 POSTS" in the status line — it used the
  non-pluralising `postsTitle` key rather than `postCount`, which already has
  singular and plural forms.

### Added

- **Both CRT overlays are dropped for readers whose OS asks for more contrast**
  (`forced-colors: active`, `prefers-contrast: more`). Removed rather than
  dimmed: the intensities are written as inline custom properties on the
  overlay elements, which beat any stylesheet override.
- `poweredBy` and `themeLabel` i18n keys. The footer hardcoded "Powered by" and
  "Theme:" in English on every page, including fully translated ones — the one
  gap in an otherwise complete i18n surface.
- Dependabot for the `github-actions` ecosystem, grouped into a single monthly
  PR. Deliberately not `gomod`: `go.mod` declares the module path so the theme
  can be consumed as a Hugo Module and has no dependencies to update.
- The full SIL Open Font License 1.1 text for Fira Code. `LICENSE-FONTS.md`
  claimed the font terms were "reproduced here" and the README claimed it held
  the full texts; neither was true, and OFL 1.1 requires the licence accompany
  the bundled font. Glass TTY VT220 is unaffected — The Unlicense imposes no
  notice-retention condition.

### Changed

- **Gallery screenshots recaptured.** `images/screenshot.png` and
  `images/tn.png` were framed at a viewport wide enough that the content column
  filled only ~52% of the frame, leaving body text illegible at the ~350px the
  gallery card actually renders. Recaptured so content fills ~64%, and rendered
  at 3000x2000 before downsampling so both are crisp on HiDPI.
- `exampleSite/static/images/terminal-demo.png`, embedded in the demo's
  markdown reference post, was a byte-identical copy of the pre-1.0.4
  thumbnail: it showed a `[ POSTS ]` nav item the theme deliberately hides, was
  missing `[ ARCHIVE ]`, and carried 2024 dates matching no content in the
  repo. Refreshed.
- The starter configs in `README.md` and `INSTALLATION.md` no longer ship the
  theme author's real GitHub handle. Anyone pasting them verbatim got a footer
  icon pointing at someone else's profile.
- `INSTALLATION.md`'s reference configs now include the
  `[markup.goldmark.extensions] typographer = false` the README says is
  required on the default font.
- `.gitignore` no longer excludes all of `exampleSite/layouts/` — narrowed to
  the two files `scripts/build-demo.sh` generates, so a real template override
  added there can't be silently skipped by `git add -A`.
- The demo build sets an `ogImage`, so shared links unfurl with a card. Set in
  the per-scheme overlay configs rather than `exampleSite/hugo.toml`, which
  doubles as the starter config people copy.
- Corrected comments in `hugo.toml` and `theme.toml` that overstated what
  themes.gohugo.io reads, and a README line documenting a hex-validation
  pattern that no longer matched the templates.

### Removed

- Two no-op `prefers-reduced-motion` rules targeting an animation
  `.crt-scanlines` never had, and an unused `hideLabels` parameter that
  `social-icons.html` accepted, documented, and never read.

## [1.0.3] - 2026-08-10

### Added

- The deployment guide now covers **cache headers on Cloudflare Pages**. Pages
  serves every asset with `Cache-Control: public, max-age=0, must-revalidate`,
  which for the theme's content-hashed stylesheet means the browser must reach
  the server before it may use the CSS on every navigation — and
  `must-revalidate` forbids falling back to the cached copy when that check is
  slow or fails, so a page can render before its stylesheet applies.
  `INSTALLATION.md` has a `static/_headers` snippet that fixes it.

### Fixed

- **CRT effects no longer tear away from the bottom of the viewport while
  scrolling on mobile.** `.crt-overlay` was sized in `dvh`, the *dynamic*
  viewport height, which tracks the mobile browser's toolbar as it retracts
  and expands during a scroll. That resized the overlay on nearly every frame
  of a fling, and each resize meant relaying out and repainting a
  full-viewport repeating gradient. The compositor scrolls new content into
  view faster than that repaint lands, so a band at the bottom of the screen
  rendered without scanlines or vignette until scrolling stopped. It is now
  sized in `lvh`, which is fixed for the life of the page, so the layer stays
  stable and composited. Desktop was unaffected — no retracting toolbar.

## [1.0.2] - 2026-08-06

### Fixed

- **ASCII art headers no longer overflow narrow viewports.** `.header-inner` is
  a column flex container with `align-items: center`, which sizes children to
  their max-content width — so art wider than the screen widened the header and
  with it the whole document, pushing the header box and MENU toggle off-screen
  and horizontally scrolling every page. `.ascii-header`'s existing
  `overflow-x` never engaged, because the `<pre>` was being handed all the
  width it asked for.

  Art that doesn't fit now scales down instead of being clipped. Both bundled
  faces are monospaced with a known advance (Glass TTY VT220 0.5em, Fira Code
  0.6154em), so `header.html` measures the widest line and emits the font size
  at which the art exactly spans the header; the stylesheet takes the smaller
  of that and the configured size. Art that already fits is untouched, and
  `asciiScale` still applies wherever there's room for it.

  Browsers without container-query support keep the previous rendering, which
  is now a self-contained scrollable `<pre>` rather than a broken page.

## [1.0.1] - 2026-08-05

### Changed

Upgrading from 1.0.0 changes some visible defaults. None of it needs
configuration, but it will look different:

- **Body text is wider.** `--content-max` is now `40rem` instead of `720px`.
  The Glass TTY VT220 advance is exactly 0.5em, so 40rem is genuinely 80
  columns at any base font size — the old 720px measured 72 while the config
  comment claimed "~80". To keep the previous measure, set
  `params.scanlines.layout.contentWidth = "36rem"`.
- **The current nav item lost its `[*ITEM*]` asterisks.** It is now marked by
  increased intensity alone, plus `aria-current="page"` for assistive
  technology — the nav reads as a clean uniform row. Every page already names
  itself in its title and heading, so the highlight is redundant emphasis
  rather than the sole cue.
- **List bullets are `*` rather than `>`.** A greater-than sign is a prompt
  character, not a bullet.
- **Italics are gone** from blockquotes, empty states and syntax comments.
  Neither bundled font has an italic face, so those were browser-synthesised
  shears. Inline `<em>` and `<strong>` are untouched.
- **Sites should set `[markup.goldmark.extensions] typographer = false`** when
  using the default `fontFamily = "glass"`. Glass TTY VT220 has no curly quotes
  or em dashes, so Hugo's typographer output silently fell back to another face
  mid-sentence. Fira Code has the full repertoire and needs no change.
- Pagination gained `flex-wrap`, the 404's message stack uses correct OpenVMS
  continuation syntax, and the status line is now described as the VT320 feature
  it actually is rather than a VT220 one.
- The demo site moved off the author's personal site to a dedicated deployment
  at <https://scanlines.pages.dev>, which shows all four phosphors with CRT
  effects both on and off.

### Fixed

- The footnote back-link was keyboard-inaccessible for one commit
  (`visibility: hidden` removes an element from the tab order). Fixed before
  release; noted here because the pattern is worth not repeating.
- Syntax comments composited to 3.76:1, under WCAG AA. Now 6.40:1.
- The 404's terminal box no longer overflows a 320px viewport, and no longer
  draws itself with box-drawing glyphs the bundled font lacks.

## [1.0.0] - 2026-07-27

First tagged release. Everything below landed before 1.0.0 — the theme was
developed in the open on `main` and this entry consolidates that history.

### Added

- **Two homepage modes** — blog (recent posts) or profile (landing page with
  avatar, bio, social icons and configurable buttons).
- **Four phosphor color schemes** — amber (P3), green (P1), blue and white, all
  meeting WCAG AA for normal text, plus custom color overrides via
  `params.scanlines.colors` with hex validation.
- **Pure-CSS CRT effects** — scanlines, phosphor glow, screen flicker, vignette
  and screen curvature, each individually configurable.
- **Terminal status line** — a fixed 25th-line status bar. The 25th line is a
  VT320 feature (the VT220 had 24 lines); the theme borrows it deliberately.
- **ASCII art header** — load custom art from a file in `static/`, with an
  `asciiScale` size multiplier.
- **JSON-LD structured data** — `BlogPosting` on posts, `WebPage` on other
  pages, `WebSite` on the home page, and a `Person` node in profile mode.
- **`contentSection` option** so the homepage, archive, section list and 404
  work with a renamed content directory instead of a hardcoded `posts`.
- **Categories support** — categories render on posts, and taxonomy term pages
  are labelled by their own taxonomy.
- **Markdown render hooks** — lazy-loaded images, hover-revealed heading
  permalinks, and external links that open in a new tab.
- **Internationalization** — all user-facing strings, including screen-reader
  labels, run through Hugo's `i18n` with English fallbacks; ships `i18n/en.toml`
  as a translation template.
- **WOFF2 fonts** — Glass TTY VT220 and Fira Code, self-hosted.
- **Archive page** (`layout: "archives"`) grouping every post by year.
- Site-wide default Open Graph image via `params.scanlines.ogImage`.
- Theme-root `hugo.toml` declaring `[module.hugoVersion]` (extended, min
  0.146.0) so module consumers and the theme gallery see the real constraints.
- GitHub Actions workflow building the exampleSite across a Hugo version matrix
  and failing on warnings; issue templates; `.editorconfig`.
- Documentation: post front-matter reference, deployment guide (GitHub Pages
  subpaths, Cloudflare Pages, Netlify), and integration recipes for comments,
  analytics, search and server-side math.

### Changed

- **Minimum Hugo version is 0.146.0 extended** — the markdown render hooks live
  in `layouts/_markup/`, which requires the 0.146+ template system.
- **Links are standard underlined hyperlinks.** Content and footer credit links
  underline; external links open in a new tab with `rel="noopener noreferrer"`
  and no visual marker. Tag chips are lowercase (`#tag`); category chips keep
  their case.
- **Custom `contentSection` gets the full post list** — the rich listing
  (reading time, tag chips, POSTS heading) lives in `_default/section.html`, so
  a renamed posts directory keeps it instead of falling back to a bare list.
- **Taxonomy links use `.GetTerms`** instead of hardcoded `/tags/` + `urlize`,
  honoring renamed taxonomies, custom permalinks and `disablePathToLower`.
- **TOC defaults are section-aware**: posts show a TOC by default; other pages
  opt in with `toc: true`.
- Open Graph/Twitter cards use `summary_large_image` when an image is available
  and add `og:locale`, `og:image:alt`, and `article:author`/`section`.
- The exampleSite uses `pageRef` menu entries, so the active-nav styling applies
  (url-style entries also work).
- Font licenses moved from `LICENSE` to `LICENSE-FONTS.md`, so `LICENSE` is
  verbatim MIT and detected as such.

### Fixed

- **Pagination** — templates paginated a different collection than they
  rendered, so every page showed the full list. Paginated pages also
  self-canonicalize now (`/posts/page/2/` and taxonomy term pages point
  `rel=canonical`/`og:url` at their own URL, not page 1), and the pager uses the
  theme's terminal styling instead of Hugo's unstyled embedded markup.
- **Subdirectory baseURL** — home/branding links, favicon, profile
  buttons/avatar, share images and the blog-mode "Posts" menu auto-hide all
  resolve under a subpath (e.g. GitHub Pages project sites) instead of escaping
  to the host root.
- **Keyboard-operable disclosures** — the collapsible TOC is a native
  `<details>`/`<summary>` and the mobile-nav toggle is focusable with a visible
  focus ring; collapsed nav links leave the tab order. Both previously relied on
  a `display:none` checkbox no keyboard could reach.
- **RSS** — the home feed carries only the configured content section, skips
  dateless pages (which emitted `pubDate` of year 0001), and ships plain-text
  descriptions instead of heading-anchor and syntax-highlighting markup. Feed
  `<link>` tags are escaped and section feeds get distinct titles.
- **404 page** is no longer indexable (robots `noindex`, no self-canonical).
- **CRT master toggle** — `effects.enabled = false` removes the screen
  curvature/vignette, and `effects.vignette = false` removes the second,
  hardcoded vignette layer (no more stacked vignettes).
- **Reduced motion** — every animation, including the opt-in flicker, stops
  under `prefers-reduced-motion`; `flickerIntensity` is validated and clamped.
- **Printing** — printed pages remap to ink-on-paper instead of pale amber on
  near-black; the status line and glow are dropped, and colored syntax mode
  prints legibly.
- **Accessibility** — the ASCII header exposes the site title via `role="img"`
  instead of reading art character by character; the status line is
  `aria-hidden` (it duplicated content and created a second `contentinfo`
  landmark); post navigation is skipped when there are no sibling posts; sites
  with no menu don't render an empty MENU box; heading hierarchy starts at `h1`.
- **`asciiScale` build crash** — a non-numeric value is validated and ignored
  instead of aborting the build. Hex color validation likewise rejects invalid
  5- and 7-digit values that previously broke every color that read them.
- **Meta and structured data** — homepage share cards use the site name (not
  "Home"), descriptions fall back to the page summary, the JSON-LD `Person` bio
  resolves markdown and emoji, and `theme-color` honors a custom background.
- **Dateless pages** no longer print `0001-01-01` in list views.
- **`archetypes/posts.md`** is named so Hugo actually resolves it for
  `hugo new posts/…` (was `post.md`, which never matched).
- **Syntax highlighting** — the code-block language label targets the element
  Hugo puts `data-lang` on, and table-mode line numbers stay aligned with
  wrapped code.
- **High-contrast mode** overrides `--color-accent`, so focus rings meet
  contrast; `showBox` unset matches its documented default.
- Hugo 0.158+ language deprecations: templates read the language through a
  version-branched `partials/site-language.html`, which works across the
  supported range.
- Documentation accuracy: the full configuration reference states real defaults
  (the status line and vignette are on), the required
  `[markup.highlight] noClasses = false` is flagged up front, the Go toolchain
  requirement for Hugo Modules is documented, and the quickstart shows
  `hugo server -D` so a new site isn't empty.

### Removed

- `.ttf` font fallbacks (~378 KB) — no browser that supports the theme's CSS
  needs them; both fonts ship as WOFF2 only.
- The placeholder `static/css/custom.css`, which added a render-blocking request
  to every downstream site. Sites create their own as documented.
- Dead `layouts/page/` templates the 0.146 template system no longer resolves.

[Unreleased]: https://github.com/wthouse/scanlines/compare/v1.0.5...HEAD
[1.0.5]: https://github.com/wthouse/scanlines/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/wthouse/scanlines/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/wthouse/scanlines/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/wthouse/scanlines/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/wthouse/scanlines/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/wthouse/scanlines/releases/tag/v1.0.0
