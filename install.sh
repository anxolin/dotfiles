#!/bin/bash
set -e

INSTALL_APPS=true         # --skip-install-apps
INSTALL_VIM_PLUGINS=true  # --skip-install-vim-plugins)

while [[ $# -gt 0 ]]
do
key="$1"
echo $key

case $key in
    -a|--skip-install-apps)
    INSTALL_APPS=false
    shift # past argument
    shift # past value
    ;;
    -v|--skip-install-vim-plugins)
    INSTALL_VIM_PLUGINS=false
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

#echo INSTALL_VIM_PLUGINS  = "${INSTALL_VIM_PLUGINS}"
#echo INSTALL_APPS     = "${INSTALL_APPS}"


cat << EOF


┬ ┬  ┌─┐  ┬    ┌─┐  ┌─┐  ┌┬┐  ┌─┐
│││  ├┤   │    │    │ │  │││  ├┤
└┴┘  └─┘  ┴─┘  └─┘  └─┘  ┴ ┴  └─┘
┌┬┐  ┌─┐
 │   │ │
 ┴   └─┘
╔═╗╔╗╔═╗ ╦╔═╗    ┌─┐
╠═╣║║║╔╩╦╝║ ║    └─┐
╩ ╩╝╚╝╩ ╚═╚═╝    └─┘
┌┬┐┌─┐┌┬┐┌─┐┬┬  ┌─┐┌─┐
 │││ │ │ ├┤ ││  ├┤ └─┐
─┴┘└─┘ ┴ └  ┴┴─┘└─┘└─┘

EOF
# Calvin S ascii font :)
# http://patorjk.com/software/taag/#p=display&f=Calvin%20S&t=w%20e%20l%20c%20o%20m%20e%0At%20o%0AANXO%20'%20s%0Adotfiles

# dotfiles directory
DOT_FILES=~/dotfiles

PLATFORM=$(uname);
printf "[dotfiles] *** INSTALL DOT FILES ($PLATFORM) ***\n"


cat << EOF

┌┐ ┌─┐┌─┐┬┌─┬ ┬┌─┐
├┴┐├─┤│  ├┴┐│ │├─┘
└─┘┴ ┴└─┘┴ ┴└─┘┴
┌─┐┬  ┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐┬┬  ┌─┐┌─┐
│ ││   ││   │││ │ │ ├┤ ││  ├┤ └─┐
└─┘┴─┘─┴┘  ─┴┘└─┘ ┴ └  ┴┴─┘└─┘└─┘
EOF
# Backup Dotfiles
source "$DOT_FILES/install/dotfiles_backup.sh"


cat << EOF


┬  ┬┌┐┌┬┌─
│  ││││├┴┐
┴─┘┴┘└┘┴ ┴
┌┬┐┌─┐┌┬┐┌─┐┬┬  ┌─┐┌─┐
 │││ │ │ ├┤ ││  ├┤ └─┐
─┴┘└─┘ ┴ └  ┴┴─┘└─┘└─┘
EOF

# Wipe previous dotfiles and instal new ones
source "$DOT_FILES/install/dotfiles_wipe-and-install.sh"
if [[ $PLATFORM == 'Darwin' ]]; then
  # Visual Studio Code dotfiles is handled separately
  source "$DOT_FILES/install/dotfiles_wipe-and-install-visual-studio-mac.sh"
fi


cat << EOF


╔═╗┬┌┬┐                       
║ ╦│ │                        
╚═╝┴ ┴                        
╔═╗┬ ┬┌┐ ┌┬┐┌─┐┌┬┐┬ ┬┬  ┌─┐┌─┐
╚═╗│ │├┴┐││││ │ │││ ││  ├┤ └─┐
╚═╝└─┘└─┘┴ ┴└─┘─┴┘└─┘┴─┘└─┘└─┘
EOF

# Install submodules
printf "[dotfiles] Init Git submodules: ZSH + Themes + Vim plugins\n"
source "$DOT_FILES/install/init_submodules.sh"
mkdir -p ~/.zsh_local
touch ~/.zsh_local/alias.zsh ~/.zsh_local/config.zsh ~/.zsh_local/dev.zsh ~/.zsh_local/path.zsh


cat << EOF


┬┌┐┌┌─┐┌┬┐┌─┐┬  ┬
││││└─┐ │ ├─┤│  │
┴┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘
┌─┐┌─┐┌─┐┌─┐
├─┤├─┘├─┘└─┐
┴ ┴┴  ┴  └─┘
EOF
if $INSTALL_APPS; then
  # Install apps
  #   TODO: Ask whether to install or not
  if [[ $PLATFORM == 'Linux' ]]; then
    source "$DOT_FILES/install/install-apps_Linux.sh"
  elif [[ $PLATFORM == 'Darwin' ]]; then
    source "$DOT_FILES/install/install-apps_Mac.sh"
  fi
else
  printf "[dotfiles] Skip install apps\n"
fi


cat << EOF


┬  ┬┬┌┬┐
└┐┌┘││││
 └┘ ┴┴ ┴
┌─┐┌─┐┌┐┌┌─┐┬┌─┐
│  │ ││││├┤ ││ ┬
└─┘└─┘┘└┘└  ┴└─┘
EOF
# Prepare vim: required dirs and Vundle plugin manager
source "$DOT_FILES/install/dotfiles_vim.sh"
source "$DOT_FILES/install/dotfiles_nvim.sh"


cat << EOF


┬  ┬┬┌┬┐
└┐┌┘││││
 └┘ ┴┴ ┴
┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
├─┘│  │ ││ ┬││││└─┐
┴  ┴─┘└─┘└─┘┴┘└┘└─┘
EOF
if $INSTALL_VIM_PLUGINS; then
  # Install all the plugins
  source "$DOT_FILES/install/dotfiles_install-vim-plugins.sh"
else
  printf "[dotfiles] Skip install vim plugins\n"
fi

printf "[dotfiles] Nice! All dotfiles are configured\n"
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
