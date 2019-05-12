###########################
#  GENERAL BASH CONFIG    #
###########################
# Base config for ~./bashrc
#     ~./bashrc can add its own local config, but main config should be in 
#     this versioned dotfile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add colors
export CLICOLOR=YES
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Add colors to ls command
alias ls='ls -G'
alias ll='ls -lG'

# Prompt style
# http://bashrcgenerator.com/
#PS1='[\u@\h \W]\$ '
export PS1="\[\033[38;5;161m\]\u\[$(tput sgr0)\]\[\033[38;5;248m\]@\[$(tput sgr0)\]\[\033[38;5;214m\]\h\[$(tput sgr0)\]\[\033[38;5;248m\]:[\[$(tput sgr0)\]\[\033[38;5;15m\]\w\[$(tput sgr0)\]\[\033[38;5;248m\]]\[$(tput sgr0)\]\[\033[38;5;248m\]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Make sure SSH agent is running (and only one instance of it)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# NVM Bash autocompletion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion