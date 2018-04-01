# Dotfiles
Installs the preferences for aplications such as `tmux`, `zsh` or `vim`.

There's also documentation showing the plugins and configuration for:

* **vim**: [docs/vim.md](docs/vim.md) Plugins, mappings and configurations.
* **tmux**: [docs/tmux.md](docs/tmux.md) Configurations.
* **zsh**: [doc/zsh.md](docs/zsh.md) Theme, plugins and configurations.

It also contains some usefull scipts used when setting up a new working environment:

* [install.sh](install.sh): Installs the dotfiles in a new environment.
It doesn't delete anything. Conflicting files will be moved to "backup.`${date}`
* [install-after.sh](install.sh): Install some plugins or external programs required by some vim plugins (i.e. Tern for JS development)

## Setup the environment
The following commands will:

* Install `zsh` with a custom theme.
* Install `ag` (the silver searcher)
* Install `vim`
* In Linux installs the `xclip`
* Backup the old dotfiles and install the new ones.

**Install the dotfiles using the script**

```bash
cd
git clone https://github.com/anxolin/dotfiles.git
chmod +x ./dotfiles/install.sh
./dotfiles/install.sh
```

Optionally, the `install.sh` accepts:
* `--skip-install-apps`: Do not install apps like vim, tmux, etc.
* `--skip-install-vim-plugins`: Do not install vim plugins

## Run it with docker
```bash
docker run anxolin/alpine-dotfiles zsh
```

## Another configuration
### In macOs
Download `iTerm2` from https://www.iterm2.com

* Set the color-preset to **solarized-dark** (in `settings > profiles > colors`)
* Set the report terminal type to **xterm-256color** (in `settings > profiles > terminal`)
* Set the font to **12pt Menlo** (or **Monaco**)  ~~**12pt DejaVu Sans Mono for Powerline**~~
* Set the vertical character spacing to 120%

### In Linux
In `Konsole`, set the font to 12pt Oc
