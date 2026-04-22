# Fonts

Terminal and editor glyphs require a **Nerd Font** — a patched version of a
monospace font that adds the icon range used by Powerlevel10k, lazygit,
nvim-web-devicons, etc.

## Active choice

**JetBrains Mono Nerd Font Mono** — good code legibility, ligatures available,
uniform glyph widths (the `Mono` suffix ensures single-column rendering for
alignment in tables and status bars).

## Install

Automated via `install/install-fonts.sh` (invoked by `install.sh`):

- **macOS**: Homebrew cask `font-jetbrains-mono-nerd-font`
- **Linux**: Latest release from
  [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/releases/latest),
  unzipped into `~/.local/share/fonts/JetBrainsMono/` and registered with
  `fc-cache`.

Manual run:

```bash
bash ~/dotfiles/install/install-fonts.sh
```

## Using it in your terminal

After install, set the font in your terminal emulator:

- **iTerm2**: Preferences → Profiles → Text → Font →
  `JetBrainsMono Nerd Font Mono 12`. The profile in
  `terminals/osx-iterm2/Default-profile.json` already points to this
  font — import it once via Preferences → Profiles → Other Actions →
  Import JSON Profiles.
- **Alacritty / Kitty / WezTerm**: set `font.family = "JetBrainsMono Nerd Font Mono"`
  in the respective config.
- **Terminal.app**: Preferences → Profiles → Text → Change… → pick the font.

## Swapping to another Nerd Font

Any Nerd Font works (Meslo, Fira Code, Hack, CaskaydiaCove, etc.). Change in
two places:

1. `install/install-fonts.sh` — update `FONT_NAME` to a different release
   name from the nerd-fonts repo (e.g. `Meslo`, `FiraCode`, `Hack`).
2. The terminal profile / config that selects the font.
