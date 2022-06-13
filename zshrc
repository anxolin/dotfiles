##########################
#  ZSH DIRS              #
##########################


# Path to your oh-my-zsh installation.
# IT may be overriden by .localrc, where local EXPORT vars are defined
export ZSH=~/dotfiles/oh-my-zsh
export ZSH_CUSTOM=~/dotfiles/zsh-custom


#############################
#  THEME: PowerLevel10K     #
#############################
# Theme:
#   * Themes are located in:
# 		 ~/dotfiles/zsh-custom/themes
#			 ~/dotfiles/.oh-my-zsh/themes/
#  Config: 
#      ~/dotfiles/p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# IMPORTANT:
#     p10k-instant-prompt allows to make ZSH available before all config and plugins has been loaded, so u can type already
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k.zsh.
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh


#############################
#  THEME: anxo (disabled)   #
#############################
# Theme:
#   * Themes are located in:
# 		 ~/dotfiles/zsh-custom/themes
#			 ~/dotfiles/.oh-my-zsh/themes/
#ZSH_THEME="anxo"


##########################
#  GENERAL ZSH CONFIG    #
##########################

# Default prompt
PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
RPROMPT='[%F{yellow}%?%f]'

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Default editor
export EDITOR='vim'

# Check for new versions every month
export UPDATE_ZSH_DAYS=30

##########################
#  PLUGINS               #
##########################

# PLugins
#   Add wisely, as too many plugins slow down shell startup.
#   See all:
#     https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
#     ls ~/.oh-my-zsh/plugins
plugins=(git vi-mode vscode web-search z docker docker-compose sudo npm macos systemd tmux tig zsh-syntax-highlighting zsh-autosuggestions copypath)

# OTHER: Disabled: tmuxinator vagrant zsh-better-npm-completion ssh-agent
# copypath: 
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copypath
#   Copies the path of your current folder to the system clipboard.
# macos: 
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
#   Osx utilities.
# vim-mode:
#   vim-like edition. Just press ESC when editing to enter normal mode. Then use vim keys, or press v to edit in vim
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# vscode:
#   Better integration with Visual Studio code "vsda <dir>" or "vscd <file1> <file2>"
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
# web-search
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
#   aliases for searching with Google, Wiki, Bing, YouTube and other popular services.
#   google this
# z
#  quicly allow to jump to directories you've visited
#  just type "z <fuzy-search>" and press tab
#  https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
#
# history-substring-search (disabled)
#  Adds fuzzy search for the history.
#  Disabled since now I used FZF instead

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


##############################################################
#  Configure OH MY ZSH and SOME DEFAULTS if not available    #
##############################################################
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

######################
#  OTHER CONF ZSH    #
######################

# Send to the FOREGROUND a process with control-z
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


######################
#  SOME ALIASES      #
######################
# General aliases
# Machine specific aliases are in:
#    ~/.zsh-local/alias.zsh
alias aws-list='aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key==''Name''] | [0].Value, dns: PublicDnsName, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, type: InstanceType,  launched
: LaunchTime, placement: Placement.AvailabilityZone }" --output table'

# tmuxnizator
alias mux="tmuxinator"


#######################################################
#  Setup FZF (should be applief after the plugins)    #
#######################################################
# FZF default config
#export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border -m'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi'
#export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi --color "fg:#bbccdd,fg+:#ddeeff,bg:#223344"'

#export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='ag -g ""'


# FZF: Load bindings
#   https://github.com/junegunn/fzf
FZF_PATH=~/dotfiles/bin-dependencies/fzf


# CTRL-R binding config
export FZF_CTRL_R_OPTS='--height 50% --layout=reverse --border -m --preview="" --color ""'
#export FZF_CTRL_R_OPTS='--height 50% --layout=reverse --border -m --preview="" --color "fg:#bbccdd,fg+:#ddeeff,bg:#223344"'

# CTRL-T binding config
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--height 80% --layout=reverse --border --multi --preview "bat --style=numbers --color=always --line-range :500 {}" --color ""'
# export FZF_CTRL_T_OPTS='--height 80% --layout=reverse --border --multi --preview "bat --style=numbers --color=always --line-range :500 {}" --color "bg:0,preview-bg:#223344"'

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/Cellar/fzf/0.22.0/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZF_PATH/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_PATH/shell/key-bindings.zsh"


###############################
#  LOAD SOME LOCAL CONFIG    #
###############################
# # Read all autocomplete files in zsh_autocomplete dir
# for file in ~/dotfiles/zsh_autocomplete/*; do
#   source "$file"
# done

# Load local config: Machine specific config:
#    See:
#      ~/.zsh-local
if [[ -a ~/.zsh_local ]]; then	
  # Read all config files in ~/.zsh_local
  for file in ~/.zsh_local/*.zsh; do
    #echo "Loading: $file"
    source "$file"
  done
fi