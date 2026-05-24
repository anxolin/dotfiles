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

# Re-read current mode, emit the iTerm2 preset, reload p10k, retint fzf + bat.
_theme_iterm_sync() {
  THEME_MODE=$("$HOME/dotfiles/scripts/theme-mode" 2>/dev/null || echo dark)
  _theme_iterm_apply "$THEME_MODE"
  _theme_fzf_apply
  _theme_bat_apply
  _theme_p10k_reload
}

# bat: pick the matching Catppuccin theme. Requires the .tmTheme files to be
# installed in `$(bat --config-dir)/themes/` and `bat cache --build` to have
# been run once. See docs/theme.md.
_theme_bat_apply() {
  if [ "$THEME_MODE" = light ]; then
    export BAT_THEME="Catppuccin Latte"
  else
    export BAT_THEME="Catppuccin Mocha"
  fi
}

# fzf: layer Catppuccin colors on top of the base FZF_DEFAULT_OPTS captured
# from common.zsh. Each toggle re-exports the right palette for new pickers.
# Existing live pickers keep their colors until restarted.
: ${_THEME_FZF_BASE:=${FZF_DEFAULT_OPTS:-}}
_theme_fzf_apply() {
  # Verbatim from https://github.com/catppuccin/fzf (themes/*.sh)
  local c
  if [ "$THEME_MODE" = light ]; then
    c='--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39'
    c+=' --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78'
    c+=' --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39'
    c+=' --color=selected-bg:#BCC0CC'
    c+=' --color=border:#9CA0B0,label:#4C4F69'
  else
    c='--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8'
    c+=' --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC'
    c+=' --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8'
    c+=' --color=selected-bg:#45475A'
    c+=' --color=border:#6C7086,label:#CDD6F4'
  fi
  export FZF_DEFAULT_OPTS="${_THEME_FZF_BASE} ${c}"
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

# Expose current mode as $THEME_MODE and apply iTerm2/fzf/bat colors at shell start.
export THEME_MODE
THEME_MODE=$("$HOME/dotfiles/scripts/theme-mode" 2>/dev/null || echo dark)
_theme_iterm_apply "$THEME_MODE"
_theme_fzf_apply
_theme_bat_apply

autoload -Uz add-zsh-hook 2>/dev/null && add-zsh-hook precmd _theme_iterm_precmd
