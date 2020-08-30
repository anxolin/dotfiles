# zsh dotfiles

The configuration is in `zshrc`

## Overview

- Install [Oh my ZSH](https://github.com/robbyrussell/oh-my-zsh)
- Using `Powerlevel10k` as a Theme: https://github.com/romkatv/powerlevel10k
  - Old theme: `anxo` is a custom theme based on the `robbyrussell` one.
- Install some plugins: Some of them: `git`, `docker`, `brew`, `bower`, `npm`, `redis-cli`, `sbt`, `systemd`, `tmux`, `vagrant`, `pip`, `python`
- Define some aliases (i.e. `activate` for venv python activation)

## ZSH dir navigation

Basic:

- `..`: 2 directories back
- `...`: 3 directories back, and so forth
- `-` Go back to previous directory

Use `fzf`:

- `cd **<tab>` It will filter all the subdirectories, and allow to fuzzy search one. You can also add
  `!<negative-filters>`, for example for excluding dot files (`!.`)
- `find * -type f | fzf` Search system wide, all files
- `find ~/Dropbox -type d | fzf` Search directories in Dropbox. For example add now `2020 tax declar` to narrow down the search
- `find -type f -size +1M -and -ctime -7 -exec du -h {} / | fzf`;

## More about fzf

Filtering in fzf:

- `anything`: fuzzy search `anyzing`
- `a b`: `a` and `b`
- `a | b`: `a` or `b`
- `'anything`: exact matches `anything`, otherwise it can fin `any thing`
- `^anything`: starts with `anything`
- `.png$`: Ends in `png` (png extension)
- `!anything`: Doesn't contain `anything`
- i.e `^core go$ | rb$ | py$`

If you add the key bindings:

- `ctl-r`
- `ctl-t`

Nice to use it with `awk` and `xargs`:

- `fzf | xargs ls -la`

some options:

- `-e` exact match
- `+i` case sensitive (`-i` insensitive)
- `--no-multi`

## Some interesting tools for productivity

- `fzf`: https://github.com/junegunn/fzf 🚀🚀
- `tldr`: https://github.com/tldr-pages/tldr
- `bat`: https://github.com/sharkdp/bat
  i.e. `git show v0.6.0:src/App.tsx | bat -l tsx`
  i.e. `export MANPAGER="sh -c 'col -bx | bat -l man -p'"`
  i.e. `fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'`

- `lnav`: https://github.com/tstack/lnav

* Log analyzer too

- `fd`: (TODO) https://github.com/sharkdp/fd

Also, other productivity tools for ZSH plugins:

- `z`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
- `vim-mode`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
- `copydir`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copydir
- `osx`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/osx
- `vscode`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
- `web-search`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search

Other plugins:

- `git`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
- `docker`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
- `docker-compose`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
- `sudo`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
- `npm`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
- `systemd`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
- `tmux`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
- `tig`: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tig

Make the:

- `zsh-syntax-highlighting`: https://github.com/zsh-users/zsh-syntax-highlighting
- `zsh-autosuggestions`: https://github.com/zsh-users/zsh-autosuggestions
- `history-substring-search`: https://github.com/zsh-users/zsh-history-substring-search

## Background / Foreground

Added a script to execute `fg` once you've sended something to the background.

This way, you can switch from an application (like vim) to the terminal by toggling `c-z`.

I've got the idea from https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
