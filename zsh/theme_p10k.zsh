#############################
#  THEME: PowerLevel10K     #
#############################
# Theme:
#   * Themes are located in:
# 		 ~/dotfiles/zsh/zsh-custom/themes
#			 ~/dotfiles/.oh-my-zsh/themes/
#  Config: 
#      ~/dotfiles/p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# IMPORTANT:
#     p10k-instant-prompt allows to make OMY_ZSH available before all config and plugins has been loaded, so u can type already
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k.zsh.
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh
