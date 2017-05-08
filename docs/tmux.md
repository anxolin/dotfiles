# tmux dotfiles
The configuration is in:

* `tmux.conf`: Main config
* `tmux-linux.conf`: Config for Linux (tested on debian and Arch Linux)
* `tmux-osx.conf`: Config for Mac OS.

## Overview
* Changes the default prefix key combination to `ctrl-a`
* Set the **256 terminal**
* Some style twitches 
* Enable mouse
* Status bar customization
* vim-like copy paste

## Basic bindings

* `c-a`: Default prefix key combination
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

## Install tmux manually
If you need to manually install tmux (thanks to the ultra-updated debian main repositories).

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