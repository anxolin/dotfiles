######################
#  OTHER CONF ZSH    #
######################

# GPG: point gpg-agent at the current TTY so pinentry-curses/-tty can prompt.
# Harmless when pinentry-mac is in use; required when not.
export GPG_TTY=$(tty)

# Show pretty names for Wireguard
#   https://www.reddit.com/r/WireGuard/comments/eg145w/short_script_to_show_peer_names_instead_of_public/
function wg {
  pattern=$(egrep "PublicKey.*#" /etc/wireguard/wg0.conf | cut -d ' ' -f 3- | while read line; do key=$(echo $line | cut -d ' ' -f 1); name=$(echo $line | cut -d ' ' -f 3); echo -n "s#$key#$key ($name)#; "; done)
  WG_COLOR_MODE=always $(which wg) $@ | sed -e "$pattern"
}



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

# nvim
alias v="nvim"

# Lazygit
alias lg="lazygit"

# Prefer modern replacements when installed
if command -v eza >/dev/null 2>&1; then
  alias ls="eza"
fi
if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never --style=plain"
elif command -v batcat >/dev/null 2>&1; then
  # Debian/Ubuntu ship bat as `batcat` due to a name conflict with an older tool
  alias cat="batcat --paging=never --style=plain"
  alias bat="batcat"
fi
# Debian/Ubuntu ship fd as `fdfind` due to a name conflict
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd="fdfind"
fi


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
# fzf options
# Colors are inherited from FZF_DEFAULT_OPTS (set by ~/dotfiles/zsh/theme.zsh
# based on current light/dark mode). Don't reset them here.
export FZF_CTRL_R_OPTS='--height 50% --layout=reverse --border -m --preview=""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--height 80% --layout=reverse --border --multi --preview "bat --style=numbers --color=always --line-range :500 {}"'

# fzf shell integration (key-bindings, completion). fzf is installed via
# the system package manager (brew/apt/pacman/apk); shell scripts live in
# platform-specific locations — try the usual suspects.
_source_fzf_script() {
  local name="$1" f
  for f in \
    "/opt/homebrew/opt/fzf/shell/$name" \
    "/usr/local/opt/fzf/shell/$name" \
    "/usr/share/doc/fzf/examples/$name" \
    "/usr/share/fzf/$name" \
    "$HOME/.fzf/shell/$name"; do
    if [[ -r "$f" ]]; then source "$f"; return 0; fi
  done
  return 1
}
_source_fzf_script key-bindings.zsh
[[ $- == *i* ]] && _source_fzf_script completion.zsh
unset -f _source_fzf_script


#######################################################
#  Carapace: multi-shell completion (only if installed)
#######################################################
if command -v carapace >/dev/null 2>&1; then
  autoload -U compinit && compinit
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  #zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
  source <(carapace _carapace)
fi

#######################################################
# Atuin: https://atuin.sh
#######################################################
if command -v atuin >/dev/null 2>&1; then
  source $ZSH_BASE/atuin.zsh
fi
