###########################
#  GENERAL BASH CONFIG    #
###########################
# Base config for ~./bashrc
#     ~./bashrc can add its own local config, but main config should be in 
#     this versioned dotfile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Color Grep
export GREP_OPTIONS='--color=auto'

# Color ls
if [ "$(uname)" == "Darwin" ]; then
	# Ls colors in Mac
	export CLICOLOR=YES
	export LSCOLORS="Gxfxcxdxbxegedabagacad"
	alias ls='ls -G'
	alias ll='ls -lG'
else
	# Ls colors Unix
	export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33'
	export LS_OPTIONS='--color=auto'
	#eval "`dircolors`"
	alias ls='ls $LS_OPTIONS'
fi


# Prompt style
# http://bashrcgenerator.com/
#PS1='[\u@\h \W]\$ '
export PS1="\[\033[38;5;161m\]\u\[$(tput sgr0)\]\[\033[38;5;248m\]@\[$(tput sgr0)\]\[\033[38;5;214m\]\h\[$(tput sgr0)\]\[\033[38;5;248m\]:[\[$(tput sgr0)\]\[\033[38;5;15m\]\w\[$(tput sgr0)\]\[\033[38;5;248m\]]\[$(tput sgr0)\]\[\033[38;5;248m\]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Make sure SSH agent is running (and only one instance of it)
USER=$(whoami)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" > /dev/null
fi

# NVM Bash autocompletion
#source /Users/anxo/perl5/perlbrew/etc/bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
