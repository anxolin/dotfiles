# Custom Neovim Configuration

A modern, modular Neovim configuration using lazy.nvim.

## Features

- 🚀 **Lazy loading** - Fast startup with lazy.nvim
- 🎨 **Tokyo Night** colorscheme
- 🔍 **Telescope** - Fuzzy finder for files, buffers, and more
- 🌳 **Treesitter** - Better syntax highlighting
- 💡 **LSP** - Language Server Protocol support with Mason
- ✨ **Autocompletion** - nvim-cmp with LSP integration
- 📁 **Neo-tree** - File explorer
- 🎯 **Which-key** - Keybinding hints
- 🔧 **Editor enhancements** - Auto pairs, comments, surround, git signs

## Structure

```
custom/
├── init.lua              # Main configuration
├── lua/
│   └── plugins/          # Plugin specifications
│       ├── colorscheme.lua
│       ├── editor.lua    # Editor enhancements
│       ├── lsp.lua       # LSP configuration
│       ├── telescope.lua # Fuzzy finder
│       ├── treesitter.lua
│       ├── ui.lua        # UI enhancements
│       └── which-key.lua
└── README.md
```

## Key Bindings

### Leader Key: `<Space>`

#### General
- `<Space>w` - Write file
- `<Space>q` - Quit
- `<Space>Q` - Quit all (force)
- `<Esc>` - Clear search highlight

#### Windows
- `Ctrl+h/j/k/l` - Navigate between windows

#### Files & Search (Telescope)
- `<Space>ff` - Find files
- `<Space>fg` - Live grep
- `<Space>fb` - Buffers
- `<Space>fh` - Help tags
- `<Space>fr` - Recent files
- `Ctrl+p` - Find files (alternative)

#### File Explorer (Neo-tree)
- `Ctrl+n` - Toggle file explorer
- `<Space>e` - Toggle file explorer (alternative)

#### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `gD` - Go to declaration
- `K` - Hover documentation
- `<Space>rn` - Rename
- `<Space>ca` - Code action
- `<Space>D` - Type definition

#### Git (Gitsigns)
- `]c` - Next git hunk
- `[c` - Previous git hunk
- `<Space>hs` - Stage hunk
- `<Space>hr` - Reset hunk
- `<Space>hp` - Preview hunk
- `<Space>hb` - Blame line

#### Comments
- `gc` - Toggle line comment
- `gb` - Toggle block comment

## First Launch

On first launch, lazy.nvim will automatically:
1. Clone itself
2. Install all plugins
3. Install LSP servers via Mason

This may take a few minutes.

## Managing Plugins

- `:Lazy` - Open plugin manager UI
- `:Lazy update` - Update plugins
- `:Lazy sync` - Install missing plugins and clean unused ones

## Managing LSP Servers

- `:Mason` - Open Mason UI to manage LSP servers
- `:LspInfo` - Show LSP server status

## Customization

To add new plugins, create a new file in `lua/plugins/` or add to an existing file.

Example:
```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

## Troubleshooting

- `:checkhealth` - Check for issues
- `:Lazy log` - View lazy.nvim logs
- `:LspLog` - View LSP logs
