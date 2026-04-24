#!/usr/bin/env bash
# Fuzzy-pick one or more sessions (TAB to multi-select) and kill them.
# No [cancel] row — use ESC to abort.

set -euo pipefail

FZF_ENVS="$HOME/.tmux/plugins/tmux-fzf/scripts/.envs"
[ -r "$FZF_ENVS" ] && source "$FZF_ENVS"

sessions=$(tmux list-sessions -F '#S:')
targets=$(echo "$sessions" | eval "$TMUX_FZF_BIN $TMUX_FZF_OPTIONS $TMUX_FZF_PREVIEW_SESSION_OPTIONS")
[ -z "$targets" ] && exit
echo "$targets" | sed 's/:.*$//' | sort -r | xargs -I{} tmux kill-session -t "{}"
