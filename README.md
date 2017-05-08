# Dotfiles
Installs the preferences for aplications such as `tmux`, `zsh` or `vim`.

There's also documentation showing the plugins and configuration for:

* **tmux**: [docs/tmux.md](docs/tmux.md) Configurations.
* **vim**: [docs/vim.md](docs/tmux.md) Plugins, mappings and configurations.
* **zsh**: [doc/zsh.md](docs/zsh.md) Theme, plugins and configurations.

It also contains some usefull scipts used when setting up a new working environment:

* [install.sh](): Installs the dotfiles in a new environment. It doesn't delete anything. Conflicting files will be moved to backup_`${date}`
* [install-after.sh](): Install some plugins or external programs required by some vim plugins (i.e. Tern for JS development)

## Setup the environment
The following commands will:

* Install `zsh` with a custom theme.
* Install `ag` (the silver searcher)
* Install `vim`
* In Linux installs the `xclip`
* Backup the old dotfiles and install the new ones.

**STEP 1: Install the dotfiles using the script**

```bash
cd
git clone https://github.com/anxolin/dotfiles.git
chmod +x ./dotfiles/*.sh
./dotfiles/install.sh
```
**STEP 2: Install the Vim plugins using Vundle**

After installing, install the vim plugins.

We enter `vim` (an error is thown the first time, don't worry it's ok):

```
:PluginInstall
```

**STEP 3: Install the post install script**

Install the post install script to initialize some plugins:
> IMPORTANT: `npm` is required for this step. For instance, it installs the `standard` JS lintern using node, so the Ale plugin can use it.
> SEE: "Vim Linter - Ale section" for more info.
```bash
./dotfiles/install-after.sh
```

## Another configuration
### In macOs
Download `iTerm2` from https://www.iterm2.com

* Set the color-preset to **solarized-dark** (in `settings > profiles > colors`)
* Set the report terminal type to **xterm-256color** (in `settings > profiles > terminal`)
* Set the font to **12pt DejaVu Sans Mono for Powerline**

### In Linux
In `Konsole`, set the font to 12pt Oc
