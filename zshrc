##########################
#  GENERAL ZSH CONFIG    #
##########################


# Path to your oh-my-zsh installation.
# IT may be overriden by .localrc, where local EXPORT vars are defined
export ZSH=~/dotfiles/oh-my-zsh
export ZSH_CUSTOM=~/dotfiles/zsh-custom


# Theme:
#   * Themes are located in:
# 		 ~/dotfiles/zsh-custom/themes
#			 ~/dotfiles/.oh-my-zsh/themes/
#ZSH_THEME="anxo"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Default prompt
PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
RPROMPT='[%F{yellow}%?%f]'

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git docker brew bower npm redis-cli sbt systemd tmux vagrant)

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

#####################
#  CUSTOM CONFIG    #
#####################

# Show hostname
#HOSTNAME=$(hostname)

# Default editor
export EDITOR='vim mux'

# Check for new versions every month
export UPDATE_ZSH_DAYS=30

# Load local config
if [[ -a ~/.zsh_local ]]; then	
  # Read all config files in ~/.zsh_local
  for file in ~/.zsh_local/*.zsh; do
    source "$file"
  done
fi


# PLugins
#   Add wisely, as too many plugins slow down shell startup.
#   See all:
#     https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
#     ls ~/.oh-my-zsh/plugins
plugins=(git docker sudo npm systemd tmux tig)
# tmuxinator vagrant

# plugins="git"

# zsh-better-npm-completion
#   https://github.com/lukechilds/zsh-better-npm-completion
#plugins+=(zsh-better-npm-completion)

# if which ssh-add >/dev/null 2>/dev/null  ; then
#   plugins="$plugins ssh-agent"
# fi

# if which ansible >/dev/null 2>/dev/null  ; then
#   plugins="$plugins ansible"
# fi

# if which tmuxinator >/dev/null 2>/dev/null  ; then
#   plugins="$plugins tmux tmuxinator"
# fi

# if which systemd >/dev/null 2>/dev/null  ; then
#   plugins="$plugins systemd"
# fi

# if which sbt >/dev/null 2>/dev/null  ; then
#   plugins="$plugins sbt"
# fi

# if which redis-cli >/dev/null 2>/dev/null  ; then
#   plugins="$plugins redis-cli"
# fi

# #if which npm >/dev/null 2>/dev/null  ; then
# #  plugins="$plugins npm"
# #fi

# if which brew >/dev/null 2>/dev/null  ; then
#   plugins="$plugins brew"
# fi

# if which docker >/dev/null 2>/dev/null  ; then
#   plugins="$plugins docker"
# fi
# if which kubectl >/dev/null 2>/dev/null  ; then
#   plugins="$plugins kubectl"
# fi


######################
#  OTHER CONF ZSH    #
######################


# Configure Oh My ZSH if present
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
else
  # Default config for when Oh My ZSH is not avaliable

  # Enable autocompletion
  autoload -Uz compinit
  compinit

  # Arrow base autocompletion
  zstyle ':completion:*' menu select

  # Autocompletion of command line switches for aliases
  setopt COMPLETE_ALIASES

  # History search using arrows
  autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
  zle -N up-line-or-beginning-search
  zle -N down-line-or-beginning-search
  [[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
  [[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

  # History reverse search: Bid to ctrl-r
  bindkey -v
  bindkey '^R' history-incremental-search-backward

  PLATFORM=$(uname);
  if [[ $PLATFORM == 'Darwin' ]]; then
    # Use the Original OSX color
    unset LSCOLORS
    export CLICOLOR=1
    export CLICOLOR_FORCE=1
  fi

  setopt prompt_subst
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' actionformats \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
  zstyle ':vcs_info:*' formats       \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
  zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

  zstyle ':vcs_info:*' enable git cvs svn

  # or use pre_cmd, see man zshcontrib
  vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
      echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
  }
  RPROMPT=$'$(vcs_info_wrapper)'
fi


fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#open_by_browser(){ open -a $1 $2}
#alias firefox='open_by_browser firefox'
#alias chrome='open_by_browser "Google Chrome"'
#alias aws_list='aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key==''Name''] | [0].Value, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name}" --output table'
alias aws_list='aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key==''Name''] | [0].Value, dns: PublicDnsName, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, type: InstanceType,  launched
: LaunchTime, placement: Placement.AvailabilityZone }" --output table'



# # Read all autocomplete files in zsh_autocomplete dir
# for file in ~/dotfiles/zsh_autocomplete/*; do
#   source "$file"
# done
