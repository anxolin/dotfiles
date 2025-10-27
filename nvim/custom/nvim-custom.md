# nvim-custom (Default Config)

**This is the DEFAULT Neovim configuration** - launched when you run `nvim` without any prefix.

## Quick Start

```bash
# Launch with default config (this config)
nvim

# Or explicitly
nvim-custom
```

## What's Inside

- **Plugin Manager**: lazy.nvim
- **LSP**: Full LSP support via Mason + mason-lspconfig
  - TypeScript (ts_ls)
  - Lua (lua_ls)
  - Python (pyright)
  - Rust (rust_analyzer)
- **Fuzzy Finder**: Telescope for files, buffers, grep, and more
- **Syntax Highlighting**: Treesitter
- **Git Integration**: Gitsigns + Neogit
- **Colorscheme**: Catppuccin
- **Icons**: mini.icons
- **Comments**: mini.comment

## Key Mappings

### General
- `<Space>w` - Save file
- `<Space>q` - Quit
- `<Space>Q` - Quit all (force)

### Window Navigation
- `Ctrl+h/j/k/l` - Move between windows

### Tab Navigation
- `<Space>+Left/Right` - Previous/Next tab
- `<Space>+h/l` - Previous/Next tab
- `gt` / `gT` - Built-in next/previous tab

### Telescope (Fuzzy Finder)
- `<ctrl+p`   - Find files
- `<Space>ff` - Find files
- `<Space>fg` - Live grep
- `<Space>fb` - Find buffers
- `<Space>fh` - Help tags
- `<Space>fo` - Old files (recent)

### Git
- `<Space>gg` - Open Neogit
- `<Space>gc` - Neogit commit
- `]h` / `[h` - Next/Previous hunk
- `<Space>hs` - Stage hunk
- `<Space>hr` - Reset hunk
- `<Space>hp` - Preview hunk
- `<Space>hb` - Toggle blame

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code actions
- `[d` / `]d` - Previous/Next diagnostic

## Configuration Structure

```
nvim/custom/
├── init.lua              # Main entry point
├── lua/
│   ├── config/
│   │   └── lazy.lua      # Lazy.nvim bootstrap
│   └── plugins/
│       ├── colors.lua    # Colorscheme
│       ├── comment.lua   # Comment plugin
│       ├── git.lua       # Git plugins (gitsigns, neogit)
│       ├── icons.lua     # Icons
│       ├── lsp.lua       # LSP configuration
│       ├── misc.lua      # Miscellaneous plugins
│       ├── navigation.lua # File navigation
│       ├── search.lua    # Telescope
│       └── treesitter.lua # Syntax highlighting
└── README.md            # This file
```

## Health Check

After launching, run `:checkhealth` to verify everything is working correctly.

## Customization

- Edit `init.lua` for general settings and keymaps
- Add/modify plugins in `lua/plugins/`
- LSP servers can be added in `lua/plugins/lsp.lua`

## Switching Configs

See [main nvim documentation](../../docs/nvim.md) for switching between different Neovim configurations.
