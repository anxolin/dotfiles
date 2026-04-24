#!/usr/bin/env bash
# Fuzzy-pick a session and switch to it. No [cancel] row — use ESC to abort.
# Reuses tmux-fzf's .envs to inherit the same preview + fzf-tmux config.

set -euo pipefail

FZF_ENVS="$HOME/.tmux/plugins/tmux-fzf/scripts/.envs"
[ -r "$FZF_ENVS" ] && source "$FZF_ENVS"

sessions=$(tmux list-sessions -F '#S:')
target=$(echo "$sessions" | eval "$TMUX_FZF_BIN $TMUX_FZF_OPTIONS $TMUX_FZF_PREVIEW_SESSION_OPTIONS")
[ -z "$target" ] && exit
tmux switch-client -t "${target%%:*}"
