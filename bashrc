###########################
#  GENERAL BASH CONFIG    #
###########################
# Base config for ~./bashrc
#     ~./bashrc can add its own local config, but main config should be in 
#     this versioned dotfile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


##################################
#  Basic Config                  #
##################################

# Tabs as 2 spaces
tabs -2

# tmuxnizator
alias mux="tmuxinator"

# Default editor
export EDITOR='vim mux'


#############################################
# Locale
#############################################
#   Show all locales:
#       locale -a
#   Show current locales
#       locale
#   IMPORTANT: Not ser in this file. Each OS setup sets it's local
##############################################
# LANG: Provides default value for LC_* variables that have not been explicitly set.
# LC_ALL: Overrides individual LC_* settings: if LC_ALL is set, none of the below have any effect.
# LANGUAGE: Message language
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8

## Aditional 
# LC_ADDRESS: How addresses are formatted (country first or last, where zip code goes etc.).
# LC_COLLATE: How strings (file names...) are alphabetically sorted. Using the "C" or "POSIX" locale here results in a strcmp()-like sort order, which may be preferable to language-specific locales.
# LC_CTYPE: How characters are classified as letters, numbers etc. This determines things like how characters are converted between upper and lower case.
# LC_IDENTIFICATION: Metadata about the locale information.
# LC_MEASUREMENT: What units of measurement are used (feet, meters, pounds, kilos etc.).
# LC_MESSAGES: What language should be used for system messages.
# LC_MONETARY: What currency you use, its name, and its symbol.
# LC_NAME: How names are represented (surname first or last, etc.).
# LC_NUMERIC: How you format your numbers. For example, in many countries a period (.) is used as a decimal separator, while others use a comma (,).
# LC_PAPER: Paper sizes: 11 x 17 inches, A4, etc.
# LC_RESPONSE: Determines how responses (such as Yes and No) appear in the local language
# LC_TELEPHONE: What your telephone numbers look like.
# LC_TIME: How your time and date are formatted. Use for example "en_DK.UTF-8" to get a 24-hour-clock in some programs.
#############################################

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


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source "$HOME/.cargo/env"
