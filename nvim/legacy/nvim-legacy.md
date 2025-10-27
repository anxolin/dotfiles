# nvim-legacy

Legacy Neovim configuration that sources your existing Vim configuration (~/.vimrc).

## Quick Start

```bash
nvim-legacy
```

## What's Inside

This config bridges the gap between Vim and Neovim by:
- Sourcing your existing `~/.vimrc` file
- Using your vim-plug plugins from `~/.vim/plugged/`
- Adding Neovim-specific enhancements in Lua
- Maintaining compatibility with your Vim workflow

## Why Use This?

- **Gradual Migration**: Keep using your Vim config while exploring Neovim features
- **Plugin Compatibility**: Continue using vim-plug and your existing plugins
- **Fallback**: Always have a working config that matches your Vim setup
- **Testing**: Compare behavior between pure Vim and Neovim with same config

## Configuration Structure

```
nvim/legacy/
├── init.lua    # Sources .vimrc + adds Neovim features
└── README.md   # This file
```

## Key Features

- Reuses `~/.vim` and `~/.vimrc`
- Preserves all your Vim keymaps and settings
- Adds Lua-native quality-of-life improvements
- Same plugins as regular Vim (CoC, NERDTree, fzf, etc.)

## Disabled Providers

To reduce warnings in `:checkhealth`:
- Perl provider: disabled
- Ruby provider: disabled

Node.js and Python providers are enabled if installed.

## Vim Configuration

See [Vim documentation](../../docs/vim.md) for more information.
