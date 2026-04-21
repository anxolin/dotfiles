# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/anxo/dotfiles/bin-dependencies/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/anxo/dotfiles/bin-dependencies/fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/Users/anxo/dotfiles/bin-dependencies/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/Users/anxo/dotfiles/bin-dependencies/fzf/shell/key-bindings.zsh"
