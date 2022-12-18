##########################
#  ZSH DIRS              #
##########################

# Path to your oh-my-zsh installation.
# IT may be overriden by .localrc, where local EXPORT vars are defined
export ZSH_BASE=~/dotfiles/zsh
export ZSH="$ZSH_BASE/oh-my-zsh"
export ZSH_CUSTOM="$ZSH_BASE/zsh-custom"

#############################
#  THEME                    #
#############################

source $ZSH_BASE/theme_p10k.zsh

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
source $ZSH_BASE/plugins.zsh

##############################################################
#  Configure OH MY ZSH and SOME DEFAULTS if not available    #
##############################################################
# Configure Oh My ZSH if present
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
else
  # Default config for when Oh My ZSH is not avaliable
  source $ZSH_BASE/oh-my-zsh-unavailable.zsh
fi

###############################
#  LOAD COMMON CONFIG         #
###############################

source $ZSH_BASE/common.zsh

###############################
#  LOAD SOME LOCAL CONFIG    #
###############################

# Load local config: Machine specific config:
#    See:
#      ~/.zsh-local
if [[ -a ~/.zsh_local ]]; then	
  # Read all config files in ~/.zsh_local
  for file in ~/.zsh/*.zsh; do
    #echo "Loading: $file"
    source "$file"
  done
fi