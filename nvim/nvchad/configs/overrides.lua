local M = {}

M.treesitter = {
  ensure_installed = {
    -- Core languages
    "vim",
    "lua",
    "c",
    "cpp",
    "python",
    "rust",
    "go",
    "java",
    
    -- Web development
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "toml",
    
    -- Markup and documentation
    "markdown",
    "markdown_inline",
    
    -- Shell and config files
    "bash",
    "dockerfile",
    "gitignore",
    "gitcommit",
    
    -- Other common formats
    "solidity",
    "graphql",
    "sql",
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    -- Disable highlighting for languages that don't have parsers
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  -- Auto-install missing parsers
  auto_install = true,
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
