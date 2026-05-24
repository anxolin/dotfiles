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
