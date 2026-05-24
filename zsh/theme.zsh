######################
#  THEME (light/dark) #
######################
# `theme` — light/dark mode helper. Wraps ~/dotfiles/scripts/theme-mode.
#
#   theme            print current mode (light|dark)
#   theme light      force light
#   theme dark       force dark
#   theme auto       follow OS appearance
#   theme toggle     flip current mode
#
# Effect is system-wide: writes ~/.config/theme-mode, then live-reloads tmux
# and signals nvim instances (they watch ~/.local/state/theme-mode.event).
# Each zsh prompt re-asserts the iTerm2 color preset, so other panes update
# on their next prompt.
theme() {
  local script="$HOME/dotfiles/scripts/theme-mode"
  if [ ! -x "$script" ]; then
    echo "theme: $script not found or not executable" >&2
    return 1
  fi
  case "${1:-}" in
    ""|current) "$script" ;;
    light|dark|auto) "$script" set "$1"; _theme_iterm_sync ;;
    toggle) "$script" toggle; _theme_iterm_sync ;;
    *) echo "Usage: theme [current|light|dark|auto|toggle]" >&2; return 2 ;;
  esac
}

# Emit the iTerm2 OSC 1337 SetColors=preset for the given mode. Wrapped in
# tmux DCS passthrough when inside tmux (requires `allow-passthrough on`).
# No-op on non-iTerm2 terminals — they ignore the escape.
_theme_iterm_apply() {
  local mode="${1:?}" preset
  if [ "$mode" = light ]; then preset=catppuccin-latte; else preset=catppuccin-mocha; fi
  if [ -n "$TMUX" ]; then
    printf '\ePtmux;\e\e]1337;SetColors=preset=%s\a\e\\' "$preset"
  else
    printf '\e]1337;SetColors=preset=%s\a' "$preset"
  fi
}

# Re-read current mode, emit the iTerm2 preset, and reload p10k for the new mode.
_theme_iterm_sync() {
  THEME_MODE=$("$HOME/dotfiles/scripts/theme-mode" 2>/dev/null || echo dark)
  _theme_iterm_apply "$THEME_MODE"
  _theme_p10k_reload
}

# Re-source the right p10k config and ask p10k to reload its prompt in-place.
# A new shell would do this naturally via theme_p10k.zsh; this is the hot path.
_theme_p10k_reload() {
  if [[ "$THEME_MODE" == light && -f ~/dotfiles/zsh/p10k-light.zsh ]]; then
    source ~/dotfiles/zsh/p10k-light.zsh
  elif [[ -f ~/dotfiles/zsh/p10k.zsh ]]; then
    source ~/dotfiles/zsh/p10k.zsh
  fi
  (( $+functions[p10k] )) && p10k reload 2>/dev/null
}

# precmd hook: cheap mtime check on the event file. If it changed since the
# last prompt in this shell, re-emit the preset. Lets other panes catch up
# on their next prompt after a `theme` toggle anywhere.
_theme_iterm_mtime=""
_theme_iterm_precmd() {
  local event="${XDG_STATE_HOME:-$HOME/.local/state}/theme-mode.event"
  local mt
  mt=$(stat -f '%m' -- "$event" 2>/dev/null || stat -c '%Y' -- "$event" 2>/dev/null || echo "")
  if [ -n "$mt" ] && [ "$mt" != "$_theme_iterm_mtime" ]; then
    _theme_iterm_mtime="$mt"
    _theme_iterm_sync
  fi
}

# Expose current mode as $THEME_MODE and apply iTerm2 colors at shell start.
export THEME_MODE
THEME_MODE=$("$HOME/dotfiles/scripts/theme-mode" 2>/dev/null || echo dark)
_theme_iterm_apply "$THEME_MODE"

autoload -Uz add-zsh-hook 2>/dev/null && add-zsh-hook precmd _theme_iterm_precmd
