# Theme (light / dark)

Switch nvim, tmux, iTerm2 and VS Code between **catppuccin-latte** (light) and **catppuccin-mocha** (dark) in one command. Follows macOS appearance by default; override anytime.

## Use

```sh
theme            # current mode
theme light      # force light
theme dark       # force dark
theme auto       # follow macOS
theme toggle     # flip
```

- nvim: `:ThemeLight` / `:ThemeDark` / `:ThemeAuto` / `:ThemeToggle`
- tmux: `prefix + t`
- VS Code: auto, no command (uses `window.autoDetectColorScheme`)

## How it works

- `scripts/theme-mode` — source of truth. Reads macOS appearance (`defaults read -g AppleInterfaceStyle`), or a manual override in `~/.config/theme-mode`. Touches `~/.local/state/theme-mode.event` on every change.
- `zsh/theme.zsh` — defines `theme`, sets `$THEME_MODE`, and emits the iTerm2 OSC 1337 `SetColors=preset` for each prompt where the event-file mtime changed.
- `nvim/lua/plugins/colors.lua` — catppuccin in `auto` mode; `fs_poll` watches the event file every 2s.
- `tmux/tmux.conf` — picks `@catppuccin_flavor` from the script at startup; `bind t` toggles + live-reloads.
- `vscode/settings.json` — `window.autoDetectColorScheme: true` + preferred light/dark themes.

## iTerm2: one-time setup

Import both presets so OSC `SetColors=preset=...` can find them by name:

1. iTerm2 → **Settings → Profiles → Colors → Color Presets… → Import…**
2. Pick `terminals/osx-iterm2/presets/catppuccin-latte.itermcolors` and `catppuccin-mocha.itermcolors`.

Each new shell applies the right preset for its pane. After `theme toggle`, the active pane updates immediately; idle panes update on their next prompt.

## bat

Catppuccin themes are vendored in `bat/themes/` and installed by `install.sh` (symlinks them into `$(bat --config-dir)/themes/` then runs `bat cache --build`). `theme.zsh` exports `BAT_THEME=Catppuccin Latte` (or `Mocha`) based on mode. Used by `bat`, fzf previews, and `MANPAGER`.

Re-run `bash install/install-bat.sh` if you ever blow away `~/.config/bat/`. Pull upstream theme updates with `bash scripts/update-bat-themes.sh` (uses `curl`, no `gh` needed) — review with `git diff bat/themes/` before committing. Source themes: [catppuccin/bat](https://github.com/catppuccin/bat).

## lazygit

Catppuccin themes vendored in `lazygit/themes/` (latte/mocha, `mauve` accent to match the rest). `install/install-lazygit.sh` symlinks `~/.config/lazygit/config.yml` at the right one; `theme.zsh` re-points on toggle. Running lazygit instances aren't repainted — close + reopen to see the new theme.

Refresh from upstream with `bash scripts/update-lazygit-themes.sh [accent]` (defaults to `mauve`; accepts `blue`, `lavender`, `peach`, etc.). Source themes: [catppuccin/lazygit](https://github.com/catppuccin/lazygit).

## Powerlevel10k: one-time light config

P10k uses hardcoded color indices — switching the iTerm2 palette alone doesn't make the prompt light. Generate a light variant with the wizard:

```sh
POWERLEVEL9K_CONFIG_FILE=~/dotfiles/zsh/p10k-light.zsh p10k configure
# pick the Light style, save
```

`theme_p10k.zsh` auto-loads `p10k-light.zsh` when mode is `light`, falls back to `p10k.zsh` otherwise. To regenerate the dark variant the same way:

```sh
POWERLEVEL9K_CONFIG_FILE=~/dotfiles/zsh/p10k.zsh p10k configure
```

## Caveats

- VS Code switches **automatically** with the OS, not with the manual `theme` override (its setting only reads system appearance).
- Inside tmux, iTerm2 colors require `allow-passthrough on` (tmux ≥ 3.3, already set).
- On Linux the script reads GNOME's `color-scheme`; on other DEs it falls back to dark.
