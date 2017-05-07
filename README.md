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

### Step 1: Install the dotfiles using the script
```bash
cd
git clone https://github.com/anxolin/dotfiles.git
chmod +x ./dotfiles/*.sh
./dotfiles/install.sh
```
### Step 2: Install the Vim plugins using Vundle
After installing, install the vim plugins.

We enter `vim` (an error is thown the first time, don't worry it's ok):

```
:PluginInstall
```

### Step 3: Install the post install script
Install the post install script to initialize some plugins:
> IMPORTANT: `npm` is required for this step. For instance, it installs the `standard` JS lintern using node, so the Ale plugin can use it.
> SEE: "Vim Linter - Ale section" for more info.
```bash
./dotfiles/install-after.sh
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

### Vim Lintern - Ale
> See documentation in https://github.com/w0rp/ale

Linterns:
  * **JS**: `sudo npm install -g standard`
  * **JSON**: `sudo npm install -g jsonlint`
  * **HTML**: `sudo npm install -g htmlhint`
  * **SASS**: `sudo npm install -g sass-lint`
  * **CSS**: `sudo npm install -g stylelint` 
  * **MARKDOWN**: `sudo pip install proselint`
  * **SQL**: `gem install sqlint`
  * **Python**: Basta con instalar flake9 `python3.6 -m pip install flake8` 
  * **YAML**: `sudo pip install yamllint`

Install all the linterns:
```bash
python3.6 -m pip install flake8
pip install proselint yamllint
sudo npm install -g standard jsonlint htmlhint sass-lint stylelint
gem install sqlint
```

Keybindings:
* `c-J` Next lintern error
* `c-K` Previous lintern error


### tmux (tmux.conf, tmux-linux.conf, tmux-osx.conf)
* Changes the default prefix key combination  
* Set the 256 terminal
* Some style twitches 
* Enable mouse
* Status bar customization

Some basic bindings:

* ctrl-a: Default prefix key combination
  * `c-a |` : split vertical
  * `c-a -` : split horizontal
  * `c-a hjkl`: Move between panes using Vim keys (hjkl)
  * `c-a HJKL`:  Use the `HJKL` keys for resizing
* Copy paste like VIM:
  * `c-a ESC` Enter in 'Copy-Paste mode'
  * Move arround as you would in vim.
  * `v` to start copying
  * `y` to copy (yield)
  * `ESC` to exit 'Copy-Paste mode'
  * `c-a p` to paste
* Move arround the windows:
* `SHIFT-Left`, `SHIFT-Right` to move between windows.
* `SHIFT-Down` to create a new window.
* `C-SHIFT-Left`, `C-SHIFT-Right` to move the current window (changing their order).
* `c-a T` to move the current window to the top position (first window).

If you need to manually install tmux.
Check the last version in: https://tmux.github.io/

```bash
wget https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
tar xvf tmux-2.3.tar.gz
```

Within the tmux folder:
```bash
./configure && make
sudo make install
```

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
