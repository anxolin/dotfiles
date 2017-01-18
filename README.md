# Dotfiles
Installs the preferences for aplications such as `tmux`, `zsh` or `vim`.

It also contains some usefull scipts used when setting up a new working environment.

## Setup the environment
The following commands will:

* Install `zsh` with a custom theme.
* Install `ag` (the silver searcher)
* Install `vim`
* In Linux installs the `xclip`
* Backup the old dotfiles and install the new ones.

```bash
cd
git clone https://github.com/anxolin/dotfiles.git
./chmod +x dotfiles/install.sh
./dotfiles/install.sh
```

After installing, install the vim plugins.

We enter `vim` (an error is thown the first time, don't worry it's ok):

```
:PluginInstall
```

## Some info about the configurations
### Vim (vimrc)
* It installes the **Vundle** plugin.
* In the `.vimrc` is a list of some other plugins. Some of them are NERDTree, Ctrl-p,  Airline and Fugitive.
* It also sets the theme to the 256 color Solarized Dark Theme.
* It changes the default search tool to ag (the silver searcher) instead of ACK.

Some basic bindings are:

* ctrl-p: For fuzzy Search 
* ctrl-n: For NERDTree file explorer 

### tmux (tmux.conf, tmux-linux.conf, tmux-osx.conf)
* Changes the default prefix key combination  
* Set the 256 terminal
* Some style twitches 
* Enable mouse
* Status bar customization

Some basic bindings:

* ctrl-a: Default prefix key combination
* `|` : split vertical
* `-` : split horizontal
* Move between panes using Vim keys 
* Use the `HJKL` keys for resizing
* `v` for copy, `y` for yield, `P` for pasting.  

### zsh (zshrc, anxo.zsh-theme) 
It installes:

* The oh-my-zsh configuration framework: https://github.com/robbyrussell/oh-my-zsh
* `anxo`, a custom theme based on the `robbyrussell` one.

## Another configuration
### In macOs
Download `iTerm2` from https://www.iterm2.com

* Set the color-preset to **solarized-dark** (in `settings > profiles > colors`)
* Set the report terminal type to **xterm-256color** (in `settings > profiles > terminal`)
* Set the font to **12pt DejaVu Sans Mono for Powerline**


### In Linux
In `Konsole`, set the font to 12pt Oc