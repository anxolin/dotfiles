[![Build Status](https://travis-ci.org/anxolin/dotfiles.svg?branch=master)](https://travis-ci.org/anxolin/dotfiles)

# Dotfiles

Installs the preferences for aplications such as `tmux`, `zsh` or `vim`.

There's also documentation showing the plugins and configuration for:

- **vim**: [docs/vim.md](docs/vim.md) Plugins, mappings and configurations.
- **tmux**: [docs/tmux.md](docs/tmux.md) Configurations.
- **zsh**: [doc/zsh.md](docs/zsh.md) Theme, plugins and configurations.

It also contains some usefull scipts used when setting up a new working environment:

- [install.sh](install.sh): Installs the dotfiles in a new environment.
  It doesn't delete anything. Conflicting files will be moved to "backup.`${date}`
- [install-after.sh](install.sh): Install some plugins or external programs required by some vim plugins (i.e. Tern for JS development)

## Setup the environment

The following commands will:

- Install `zsh` with a custom theme.
- Install `ag` (the silver searcher)
- Install `vim`
- In Linux installs the `xclip`
- Backup the old dotfiles and install the new ones.

**Install the dotfiles using the script**

```bash
cd
git clone https://github.com/anxolin/dotfiles.git
chmod +x ./dotfiles/install.sh
./dotfiles/install.sh
```

Optionally, the `install.sh` accepts:

- `--skip-install-apps`: Do not install apps like vim, tmux, etc.
- `--skip-install-vim-plugins`: Do not install vim plugins

## Update submodules (depenencies)
Update the modules:
```bash
git pull --recurse-submodules
git submodule update --remote
```

Then you can reinstall any of the tools:
```bash
# Install FZF
./install/install-fzf.sh
```

## Run it with docker

Run latest docker images with:

- `--rm` Destroy the container after executing
- `--hostname` Sets a nicer hostname (shown in tmux and zsh)
- `-v ~/:/home/anxo/data` Maps `/home/anxo/data` to the host home dir
- `-it` Iterative mode
- `<image>:latest` Latest successful image (see link to all tags in Dockerhub)

```bash
# Arch
docker run --rm  --hostname=dotfiles-arch -v ~/:/home/anxo/data -it anxolin/dotfiles-arch:latest

# Alpine
docker run --rm --hostname=dotfiles-alpine -v ~/:/home/anxo/data -it anxolin/dotfiles-alpine:latest

# Ubuntu
docker run --rm --hostname=dotfiles-ubuntu -v ~/:/home/anxo/data -it anxolin/dotfiles-ubuntu:latest
```

Tags:

- **Arch**: https://hub.docker.com/r/anxolin/dotfiles-arch/tags
- **Alpine**: https://hub.docker.com/r/anxolin/dotfiles-alpine/tags
- **Ubuntu**: https://hub.docker.com/r/anxolin/dotfiles-ubuntu/tags

## Build docker image

```bash
# Build Arch, Alpine, Ubuntu
docker build --no-cache -f Dockerfile-arch -t dotfiles-arch .
docker build --no-cache -f Dockerfile-alpine -t dotfiles-alpine .
docker build --no-cache -f Dockerfile-ubuntu -t dotfiles-ubuntu .

# Arch
docker run --hostname=dotfiles-arch -v ~/:/home/anxo/data -it --rm dotfiles-arch
docker run --hostname=dotfiles-alpine -v ~/:/home/anxo/data -it --rm dotfiles-alpine
docker run --hostname=dotfiles-ubuntu -v ~/:/home/anxo/data -it --rm dotfiles-ubuntu
```

## Another configuration

### In OSX: iTerm

Download `iTerm2` from https://www.iterm2.com

Use the profile in <terminal-profiles/osx-iterm2/Default-profile.json>

Details of the profile:

- `Profiles > Colors`: Set the color-preset to **solarized-dark** (in `settings > profiles > colors`)
- `Terminal > Terminal Emulation`: Set the report terminal type to **xterm-256color**
- `Profiles > Text > Font`: Set the font to **Meslo LG M for Powerline** (important, make sure you deselect the option: `use different font for non-ASCII text`)
  - DOWNLOAD: [Meslo LG M for Powerline](https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf?raw=true)
  - Old one (until 29/08/2020): **12pt Menlo** (or **Monaco**)
  - Old one (until 18/03/2018): **12pt DejaVu Sans Mono for Powerline**
- `Profiles > Text > Font`: Set the vertical character spacing to `120%`

### In OSX: Terminal

Use the profile in <terminal-profiles/osx-terminal/Default-profile.terminal>

- `Profiles > Text > Font`: Set the font to **Meslo LGS NF Regular 12pt**
- `Profiles > Advanced > Terminfo`: Declare terminal as **xterm-256color**

### In Linux

In `Konsole`, set the font to 12pt Oc

## Some interesting tools for productivity

See tools in [doc/zsh.md](docs/zsh.md)
