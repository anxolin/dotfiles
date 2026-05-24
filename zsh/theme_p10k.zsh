#############################
#  THEME: PowerLevel10K     #
#############################
# Theme:
#   * Themes are located in:
# 		 ~/dotfiles/zsh/zsh-custom/themes
#			 ~/dotfiles/.oh-my-zsh/themes/
#  Config:
#      ~/dotfiles/zsh/p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# IMPORTANT:
#     p10k-instant-prompt allows to make OMY_ZSH available before all config and plugins has been loaded, so u can type already
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load the right p10k config for the current theme. Generated with the wizard:
#   POWERLEVEL9K_CONFIG_FILE=~/dotfiles/zsh/p10k-light.zsh p10k configure   # light
#   POWERLEVEL9K_CONFIG_FILE=~/dotfiles/zsh/p10k.zsh       p10k configure   # dark
# Falls back to dark p10k.zsh if no light variant exists yet.
_theme_mode_for_p10k=$("$HOME/dotfiles/scripts/theme-mode" 2>/dev/null || echo dark)
if [[ "$_theme_mode_for_p10k" == light && -f ~/dotfiles/zsh/p10k-light.zsh ]]; then
  source ~/dotfiles/zsh/p10k-light.zsh
elif [[ -f ~/dotfiles/zsh/p10k.zsh ]]; then
  source ~/dotfiles/zsh/p10k.zsh
fi
unset _theme_mode_for_p10k
