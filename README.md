# Dotfiles

Personal dev environment config: `zsh`, `tmux`, `nvim` (primary editor), minimal `vim` (fallback), `git`, plus VSCode keybindings and an iTerm profile. macOS-first, also tested on Debian/Arch/Alpine Linux.

## What's in here

- **zsh** — Oh My Zsh + Powerlevel10k, syntax highlighting, autosuggestions. See [docs/zsh.md](docs/zsh.md).
- **tmux** — minimal config with TPM. See [docs/tmux.md](docs/tmux.md).
- **nvim** — primary editor. lazy.nvim, Mason, Snacks, conform, treesitter. See [docs/nvim.md](docs/nvim.md).
- **vim** — fallback editor. vim-plug, CoC (or ALE without Node), fzf, fugitive, lazygit via floaterm. See [docs/vim.md](docs/vim.md).
- **git** — `git/gitconfig` (symlinked to `~/.gitconfig`) and `git/gitignore_global`. Machine-local overrides via `~/.gitconfig.local` (auto-included if present).
- **fonts** — JetBrains Mono Nerd Font. See [docs/fonts.md](docs/fonts.md).
- **vscode** — `vscode/settings.json`, `vscode/keybindings.json` symlinked into VS Code's user dir on macOS. See [docs/vscode.md](docs/vscode.md).
- **fzf** — usage notes in [docs/fzf.md](docs/fzf.md).
- **glow** — markdown renderer. Config in `glow/glow.yml`, symlinked into glow's platform config dir by `install/install-glow.sh`. Catppuccin themes in `glow/themes/`.
- **pass / gpg** — Unix password manager wiring. See [docs/pass.md](docs/pass.md) and [docs/gpg.md](docs/gpg.md).
- **terminals/osx-iterm2** — iTerm profile preset + catppuccin light/dark presets.
- **theme** — one command (`theme light|dark|auto|toggle`) flips nvim, tmux, iTerm2, VS Code and glow together. See [docs/theme.md](docs/theme.md).

## Install

```bash
cd ~
git clone https://github.com/anxolin/dotfiles.git
./dotfiles/install.sh
```

`install.sh` does:

1. Backs up existing home-side dotfiles to `~/dotfiles/backup/backup_<timestamp>/` (last 10 retained per prefix).
2. Wipes the previous symlinks and recreates them from `dotfiles.list`.
3. On macOS: also links `vscode/settings.json` and `vscode/keybindings.json` into `~/Library/Application Support/Code/User`.
4. Installs Oh My Zsh + Powerlevel10k + plugins into `~/.oh-my-zsh`.
5. Installs the tmux plugin manager (TPM).
6. Installs apps via brew (macOS) or apt/pacman/apk (Linux): zsh, ripgrep, fd, fzf, bat, glow, tldr, lnav, gh, uv, ruff, pass/gnupg, etc.
7. Installs JetBrains Mono Nerd Font.
8. Sets up nvim and vim (with vim-plug + plugin install).

Flags:

- `-a`, `--skip-install-apps` — skip the apps/fonts step.
- `-v`, `--skip-install-vim-plugins` — skip `:PlugInstall`.

## Customization

### Machine-local zsh config

`zsh/zshrc` sources every `~/.zsh/*.zsh` in alphabetical order, so a file that
builds `PATH` has to sort before whatever uses it. `install.sh` creates
`alias.zsh`, `config.zsh`, `dev.zsh` and `path.zsh` as empty files.

An entry can be a real file, or a symlink into a separate repo — one repo per
layer, so each machine runs only the layers it links in:

```sh
git clone git@example.com:me/dotfiles-extra.git ~/dotfiles-extra
for f in ~/dotfiles-extra/*.zsh; do ln -sf "$f" ~/.zsh/$(basename "$f"); done
```

Keep `~/.zsh` itself a plain directory rather than a repo, or only one layer can
fill it.

Secrets don't belong here — read them from [`pass`](docs/pass.md) at the point
of use.

### Machine-local git config

Put signing keys, per-org identities (`includeIf`) and other per-machine
settings in `~/.gitconfig.local`. It is auto-included by `git/gitconfig` and
not tracked. The installer creates
`~/.gitconfig.local` from `git/gitconfig.local.example` if it doesn't exist.

## iTerm2 (macOS)

Two one-time steps; the imported files live in `terminals/osx-iterm2/`:

1. **Profile** — `Settings → Profiles → Other Actions → Import JSON Profiles…` → `Default-profile.json`.
   Carries the font (JetBrains Mono Nerd Font Mono 12), catppuccin colors, `xterm-256color`,
   the Natural Text Editing keys (Option/Cmd + arrows and Backspace), Left Option as Esc+
   (Option+Enter inserts a newline in Claude Code) and Shift+Enter → newline (sends Ctrl+J, works through tmux).
2. **Color presets** — `Settings → Profiles → Colors → Color Presets… → Import…` → `presets/catppuccin-latte.itermcolors` **and** `catppuccin-mocha.itermcolors`.
   Both are required for `theme` to repaint iTerm2 — see [docs/theme.md](docs/theme.md).

The font needs no manual download: `install.sh` installs it via Homebrew ([docs/fonts.md](docs/fonts.md)).

<p align="center">
  <img src="./docs/images/iterm2-fonts.png" width="700" />
</p>

## Restore / revert

`install.sh` snapshots home-side dotfiles into `~/dotfiles/backup/backup_<timestamp>/` before symlinking. To revert a single file:

```bash
cp ~/dotfiles/backup/backup_<timestamp>/.zshrc ~/.zshrc
```

Retention is 10 most recent snapshots per prefix (`backup_`, `nvim_`, `tmux_`); older ones are pruned automatically on each install.

## Update

Pull latest config and re-run the relevant installer:

```bash
cd ~/dotfiles && git pull
# Re-run a specific piece if you changed something:
./install/install-zsh.sh
./install/dotfiles_nvim.sh
```

A full re-run is also safe: `./install.sh --skip-install-apps`.
