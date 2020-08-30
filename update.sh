#!/bin/bash
set -e

cat << EOF


╦ ╦┌─┐┌┬┐┌─┐┌┬┐┌─┐                
║ ║├─┘ ││├─┤ │ ├┤                 
╚═╝┴  ─┴┘┴ ┴ ┴ └─┘                
╔╦╗┌─┐┌─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌─┐
 ║║├┤ ├─┘├┤ │││ ││├┤ ││││  │├┤ └─┐
═╩╝└─┘┴  └─┘┘└┘─┴┘└─┘┘└┘└─┘┴└─┘└─┘

EOF

# Update all dependencies
echo "[dotfiles-update] Updating git submodules"
git submodule update --init --recursive

# Vundle Install: Update vim plugins
echo "[dotfiles-update] Updating vim plugins"
vim +PluginInstall +qall

# Update fzf
echo "[dotfiles-update] Install FZF"
source ~/dotfiles/install/install-fzf.sh



printf "[dotfiles] Nice! All the dependencies are updated\n"
cat << EOF


╔╦╗╔═╗╔╗╔╔═╗┬
 ║║║ ║║║║║╣ │
═╩╝╚═╝╝╚╝╚═╝o


┌─┐┌┐┌ ┬┌─┐┬ ┬   ┬┌─┐┬ ┬┬─┐
├┤ │││ ││ │└┬┘   ││ ││ │├┬┘
└─┘┘└┘└┘└─┘ ┴   └┘└─┘└─┘┴└─
┌┐┌┌─┐┬ ┬  ┌┬┐┌─┐┌┬┐┌─┐┬┬  ┌─┐┌─┐
│││├┤ │││   │││ │ │ ├┤ ││  ├┤ └─┐
┘└┘└─┘└┴┘  ─┴┘└─┘ ┴ └  ┴┴─┘└─┘└─┘

EOF