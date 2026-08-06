# Changelog

All notable changes to the Scanlines theme are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- Syntax comments composited to 3.76:1, under WCAG AA. Now 7.32:1.
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

[Unreleased]: https://github.com/wthouse/scanlines/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/wthouse/scanlines/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/wthouse/scanlines/releases/tag/v1.0.0
