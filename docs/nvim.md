# Neovim Configuration

Multi-config Neovim setup using `NVIM_APPNAME` to manage multiple configurations.

## Quick Start

```bash
# Default config (custom)
nvim

# Or use specific configs
nvim-custom     # Default - full featured config
nvim-custom2    # Alternative experimental config
nvim-legacy     # Uses your .vimrc (Vim compatibility)
nvim-empty      # Minimal config with no plugins
```

## Available Configurations

| Alias | Directory | Description | Documentation |
|-------|-----------|-------------|---------------|
| **`nvim`** ⭐ | `nvim/custom` | **DEFAULT** - Full-featured lazy.nvim config with LSP, Telescope, Treesitter | [README](../nvim/custom/nvim-custom.md) |
| `nvim-custom` | `nvim/custom` | Same as default | [README](../nvim/custom/nvim-custom.md) |
| `nvim-custom2` | `nvim/custom2` | Alternative config for testing | [README](../nvim/custom2/nvim-custom2.md) |
| `nvim-legacy` | `nvim/legacy` | Sources your .vimrc for Vim compatibility | [README](../nvim/legacy/nvim-legacy.md) |
| `nvim-empty` | `nvim/empty` | Minimal config with no plugins | [README](../nvim/empty/nvim-empty.md) |

**⭐ `custom` is the default** - running `nvim` without any prefix uses the custom config.

## How It Works

### Directory Structure

Each config in `~/dotfiles/nvim/` is symlinked to `~/.config/nvim-{name}`:

```
~/dotfiles/nvim/custom  → ~/.config/nvim-custom
~/dotfiles/nvim/legacy  → ~/.config/nvim-legacy
~/dotfiles/nvim/empty   → ~/.config/nvim-empty
# ... and more
```

### NVIM_APPNAME Environment Variable

Neovim uses `$NVIM_APPNAME` to determine which config directory to use:

```bash
# Default set in ~/.zsh/nvim.zsh
export NVIM_APPNAME=nvim-custom

# When you run 'nvim', it uses ~/.config/nvim-custom
# When you run 'nvim-legacy', it temporarily sets NVIM_APPNAME=nvim-legacy
```

### Aliases

All aliases are defined in `~/.zsh/nvim.zsh`:

```bash
export NVIM_APPNAME=nvim-custom  # Sets default

alias nvim-custom='NVIM_APPNAME=nvim-custom nvim'
alias nvim-legacy='NVIM_APPNAME=nvim-legacy nvim'
alias nvim-empty='NVIM_APPNAME=nvim-empty nvim'
# ... and more
```

## Installation

Run the installation script:

```bash
cd ~/dotfiles
./install/dotfiles_nvim.sh
```

This will:
1. Backup existing configs
2. Create symlinks for all configs
3. Install Node.js packages (neovim, vscode-langservers-extracted)
4. Install Python packages (pynvim)
5. Create `~/.zsh/nvim.zsh` with aliases
6. Set `custom` as the default config

### Manual Setup

If not already done, add to your `~/.zshrc`:

```bash
source ~/.zsh/nvim.zsh
```

Then reload:

```bash
source ~/.zshrc
```

### Notes
- Perl and Ruby providers are disabled (rarely needed)
- Missing dependencies will show warnings in `:checkhealth`

