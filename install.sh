#!/bin/bash
set -e

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


┬┌┐┌┌─┐┌┬┐┌─┐┬  ┬
││││└─┐ │ ├─┤│  │
┴┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘
┌─┐┌─┐┌─┐┌─┐
├─┤├─┘├─┘└─┐
┴ ┴┴  ┴  └─┘
EOF
# Install apps
#   TODO: Ask whether to install or not
if [[ $PLATFORM == 'Linux' ]]; then
  source "$DOT_FILES/install/install-apps_Linux.sh"
elif [[ $PLATFORM == 'Darwin' ]]; then
  source "$DOT_FILES/install/install-apps_Mac.sh"
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


cat << EOF


┬  ┬┬┌┬┐
└┐┌┘││││
 └┘ ┴┴ ┴
┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
├─┘│  │ ││ ┬││││└─┐
┴  ┴─┘└─┘└─┘┴┘└┘└─┘
EOF
# Install all the plugins
source "$DOT_FILES/install/dotfiles_install-vim-plugins.sh"


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
