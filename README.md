# Shades of Purple (Cravey) — for Zed

A [Zed](https://zed.dev/) port of **Shades of Purple**, matching Michael Cravey's
personal customization of the theme (as it looks in his Nova editor extension and
the VSCode extension it's derived from). Ships as one theme family with two dark
variants:

- **Shades of Purple** — the regular variant (`#2D2B55` editor background)
- **Shades of Purple Super Dark** — a darker variant (`#191830` editor background)

## Install

```sh
git clone <this repo> ~/Projects/shades-of-purple-zed
~/Projects/shades-of-purple-zed/install.sh
```

`install.sh` symlinks `themes/shades-of-purple.json` into
`~/.config/zed/themes/`. Restart Zed (or run `zed: reload extensions` /
`theme selector: toggle` from the command palette), then pick "Shades of
Purple" or "Shades of Purple Super Dark" from the theme selector
(`cmd-k cmd-t`).

To update after pulling changes, just re-run `install.sh` (it's idempotent —
it replaces the symlink) or, since it's a symlink, do nothing at all; edits to
`themes/shades-of-purple.json` take effect on next Zed reload automatically.

## Provenance

Built starting from [irmhonde/shades-of-purple-theme](https://github.com/irmhonde/shades-of-purple-theme),
an existing MIT-licensed Zed port (v0.0.7, ~38k downloads on the Zed
extension registry at time of writing) of Ahmad Awais's
[Shades of Purple for VSCode](https://github.com/ahmadawais/shades-of-purple-vscode).
That existing port is well-structured (full v0.2.0 schema, both variants,
sensible syntax-key coverage), so rather than hand-authoring from scratch this
repo forks its `themes/shades-of-purple-theme.json` and adjusts colors to
match Michael's actual setup, cross-referenced against two sources:

1. Michael's live Nova theme CSS
   (`~/Projects/Shades of Purple.novaextension/Themes/*.css`) — the ground
   truth for what he actually sees day to day, including his Super Dark
   customizations to window/document background and border colors.
2. The upstream VSCode extension's `tokenColors` / `colors`
   (`ahmadawais.shades-of-purple` v7.3.6, JSONC, parsed and diffed against the
   Nova CSS) — used to fill in UI surfaces Nova's CSS doesn't cover
   (activity bar, panels, minimap, peek views, git decorations, etc.) and to
   disambiguate scopes the Nova CSS doesn't spell out.

Where the two sources agreed, that value was used as-is (most of the theme —
keyword orange, comment purple italic, function/property yellow, number/
constant/boolean pink, tag/type/variable cyan). Where the original Zed fork's
colors had drifted from both sources (e.g. `variable` and `variable.parameter`
set to near-white instead of Nova's cyan, `constructor` set to yellow instead
of cyan, `string` a slightly different green, JSX `tag.attribute` swapped
green/yellow, `punctuation.bracket` not using Nova's explicit soft-yellow
bracket color), those keys were corrected. The two variants' background,
border, gutter, active-line, cursor, and selection colors were rebuilt exactly
from the Nova CSS numbers rather than approximated.

## Files

```
themes/shades-of-purple.json   # the theme family (both variants)
install.sh                     # symlinks the theme into ~/.config/zed/themes/
LICENSE.md                     # MIT, credits ahmadawais (upstream) + irmhonde (Zed fork base)
```

## Status / known rough edges

Visual verification in Zed against real JS/TS/CSS files (via the
`~/Projects/craveytrain.com` repo) was blocked in the environment this was
built in — the terminal process driving the build doesn't have macOS Screen
Recording permission, and granting it requires an interactive System Settings
toggle. The color choices above are grounded directly in Michael's live Nova
CSS and the upstream VSCode `tokenColors`, not guessed, but a pass with actual
eyes on the rendered editor (per the original plan) hasn't happened yet.
Scopes most worth double-checking first, since they're the highest-traffic
tokens and Zed's syntax vocabulary is coarser than TextMate's:

- `variable` / `variable.parameter` — set to cyan (`#9EFFFF`) per Nova's
  `identifier`/`identifier.argument` rules. The original Zed fork had these
  near-white; if plain variable references read as "too cyan" next to
  tags/types (which are also cyan), consider splitting them back out.
- `constructor` — set to cyan to match JSX component names / `new Foo()`
  (VSCode's `support.class.component` rule). Class *declarations* themselves
  (`class Foo {`) aren't distinctly covered by any Zed syntax key here; Nova
  colors those a pale lavender that has no clean Zed home.
- `type` — set to cyan universally (Nova's `identifier.type`), overriding the
  upstream TypeScript-specific mint green (`#80FFBB`) the original Zed fork
  used. If `.ts`/`.tsx` type annotations look wrong, that's the tradeoff to
  revisit.
- `punctuation.bracket` — set to Nova's explicit soft-yellow `bracket` color
  (`#FFEE80`); everything else under `punctuation.*` stays close to white.

If any of these don't match on screen, they're single-line edits in
`themes/shades-of-purple.json` (colors repeat per-variant in the `syntax`
block of each theme entry).
