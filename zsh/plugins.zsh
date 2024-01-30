##########################
#  PLUGINS               #
##########################

# PLugins
#   Add wisely, as too many plugins slow down shell startup.
#   See all:
#     https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
#     ls ~/.oh-my-zsh/plugins
plugins=(git vscode web-search z docker docker-compose sudo npm macos systemd tmux tig zsh-syntax-highlighting zsh-autosuggestions copypath)

# vi-mode 

# OTHER: Disabled: tmuxinator vagrant zsh-better-npm-completion ssh-agent
# copypath: 
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copypath
#   Copies the path of your current folder to the system clipboard.
# macos: 
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
#   Osx utilities.
# vim-mode:
#   vim-like edition. Just press ESC when editing to enter normal mode. Then use vim keys, or press v to edit in vim
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# vscode:
#   Better integration with Visual Studio code "vsda <dir>" or "vscd <file1> <file2>"
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
# web-search
#   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
#   aliases for searching with Google, Wiki, Bing, YouTube and other popular services.
#   google this
# z
#  quicly allow to jump to directories you've visited
#  just type "z <fuzy-search>" and press tab
#  https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
#
# history-substring-search (disabled)
#  Adds fuzzy search for the history.
#  Disabled since now I used FZF instead

# plugins="git"

# zsh-better-npm-completion
#   https://github.com/lukechilds/zsh-better-npm-completion
#plugins+=(zsh-better-npm-completion)

# if which ssh-add >/dev/null 2>/dev/null  ; then
#   plugins="$plugins ssh-agent"
# fi

# if which ansible >/dev/null 2>/dev/null  ; then
#   plugins="$plugins ansible"
# fi

# if which tmuxinator >/dev/null 2>/dev/null  ; then
#   plugins="$plugins tmux tmuxinator"
# fi

# if which systemd >/dev/null 2>/dev/null  ; then
#   plugins="$plugins systemd"
# fi

# if which sbt >/dev/null 2>/dev/null  ; then
#   plugins="$plugins sbt"
# fi

# if which redis-cli >/dev/null 2>/dev/null  ; then
#   plugins="$plugins redis-cli"
# fi

# #if which npm >/dev/null 2>/dev/null  ; then
# #  plugins="$plugins npm"
# #fi

# if which brew >/dev/null 2>/dev/null  ; then
#   plugins="$plugins brew"
# fi

# if which docker >/dev/null 2>/dev/null  ; then
#   plugins="$plugins docker"
# fi
# if which kubectl >/dev/null 2>/dev/null  ; then
#   plugins="$plugins kubectl"
# fi
