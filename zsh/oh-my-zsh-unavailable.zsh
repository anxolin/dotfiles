##############################################################
#  Default config for when Oh My ZSH is not avaliable        #
##############################################################

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