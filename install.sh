#!/bin/bash
set -e

INSTALL_APPS=true         # --skip-install-apps
INSTALL_VIM_PLUGINS=true  # --skip-install-vim-plugins)

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--skip-install-apps)        INSTALL_APPS=false ;;
    -v|--skip-install-vim-plugins) INSTALL_VIM_PLUGINS=false ;;
    *)                             echo "[dotfiles] Unknown option: $1 (ignored)" ;;
  esac
  shift
done


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

# Install Oh My Zsh + plugins/themes into ~/.oh-my-zsh (no longer vendored in repo)
bash "$DOT_FILES/install/install-zsh.sh"


cat << EOF


┌┬┐┌┬┐┬ ┬─┐ ┬
 │ ││││ │┌┴┬┘
 ┴ ┴ ┴└─┘┴ └─
EOF

# Install tmux plugin manager
source "$DOT_FILES/install/install-tmux.sh"


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

  # Install Nerd Font (JetBrains Mono) for terminal/p10k glyphs
  bash "$DOT_FILES/install/install-fonts.sh"
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
# Install vim and nvim
if [[ -f /etc/debian_version ]]; then
  source "$DOT_FILES/install/install-lazygit-debian.sh"
  source "$DOT_FILES/install/install-nvim-debian.sh"
fi
source "$DOT_FILES/install/dotfiles_nvim.sh"
source "$DOT_FILES/install/dotfiles_vim.sh"


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
  source "$DOT_FILES/install/install-vim-plug.sh"
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
