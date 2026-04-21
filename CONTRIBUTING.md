# Contributing to Scanlines

Thanks for taking the time to contribute. This theme is small and
opinionated — the guidelines below are short on purpose.

## Filing issues

- **Bugs**: please include your Hugo version (`hugo version`), theme
  version (commit SHA or module version), the relevant excerpt of your
  `hugo.toml`, and a minimal reproduction if possible.
- **Feature requests**: describe the use case before proposing the
  shape of the solution. The theme aims to stay minimal; new config
  options need justification.

## Pull requests

1. Fork the repo, create a branch off `main`.
2. Test against `exampleSite/`:

   ```bash
   cd exampleSite
   hugo server --themesDir ../..
   ```

   Build must pass with no warnings: `hugo --themesDir ../..`.
3. Keep changes focused. One feature or fix per PR.
4. If you're adding a config option, update both `INSTALLATION.md` and
   `exampleSite/hugo.toml` so the reference stays in sync.
5. Avoid introducing JavaScript. The theme intentionally has none.
6. Avoid external dependencies (CDN fonts, analytics scripts, tracking
   pixels, etc.). Everything should be self-hosted.

## Code style

- SCSS: 2-space indent, one rule per line, kebab-case class names.
- Templates: match the existing leading-dash whitespace style
  (`{{- ... -}}`) to keep rendered HTML clean.
- Commit messages: imperative mood, lowercased type prefix
  (`feat:`, `fix:`, `docs:`, `refactor:`, `security:`, `chore:`).

## Design principles

Scanlines is designed to feel like a VT220 terminal. Before adding a
visual effect or a layout feature, ask: "Would this have been possible
on a real VT220?" If the answer is no, the feature probably doesn't
belong — or needs a strong historical justification (e.g., the inline
collapsible TOC isn't a VT220 feature but it's a pragmatic concession
to modern reading habits).

Historical accuracy is preferred over Hollywood retro: no
screen-sweeping scan bars, no glitch-text animations, no Matrix-green
drop effects. Real CRTs had quiet flicker and phosphor persistence, and
that's it.

## Licensing

By submitting a PR, you agree that your contribution is licensed under
the same MIT License that covers the rest of the project.
