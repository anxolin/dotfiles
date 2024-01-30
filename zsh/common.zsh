######################
#  OTHER CONF ZSH    #
######################

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

# tmuxnizator
alias mux="tmuxinator"

# nvim
alias v="nvim"


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

