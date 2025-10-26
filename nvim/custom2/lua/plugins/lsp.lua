-- LSP Configuration
--
-- Documentation:
--   Mason: https://github.com/williamboman/mason.nvim
--   Mason-lspconfig: https://github.com/williamboman/mason-lspconfig.nvim
--   LSP server list: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
--   LSP config docs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
-- Common LSP servers:
--   JavaScript/TypeScript: ts_ls, eslint, biome
--   Python: pyright, ruff_lsp
--   Rust: rust_analyzer
--   Go: gopls
--   C/C++: clangd
--   Java: jdtls
--   HTML/CSS: html, cssls, tailwindcss
--   JSON: jsonls
--   YAML: yamlls
--   Markdown: marksman
--   Docker: dockerls
--   Bash: bashls
--   Lua: lua_ls

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason for easy LSP server installation
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Additional lua config for Neovim
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- LSP keymaps (applied when LSP attaches to buffer)
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", vim.lsp.buf.references, "Goto References")
        map("gI", vim.lsp.buf.implementation, "Goto Implementation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Setup Mason
      require("mason").setup()

      -- Setup mason-lspconfig with handlers
      -- Options:
      --   ensure_installed: List of servers to auto-install
      --   automatic_installation: Auto-install servers configured in lspconfig
      --   handlers: Functions to configure each server
      require("mason-lspconfig").setup({
        -- Add language servers here to auto-install them
        -- Run :Mason to see all available servers
        ensure_installed = {
          "lua_ls",        -- Lua
          "ts_ls",         -- TypeScript/JavaScript
          "pyright",       -- Python
          "rust_analyzer", -- Rust
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Custom handler for lua_ls (with special settings for Neovim)
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,

          -- Example: Custom handler for a different server
          -- Uncomment and modify to add custom settings for any server
          --
          -- ["gopls"] = function()
          --   require("lspconfig").gopls.setup({
          --     on_attach = on_attach,
          --     capabilities = capabilities,
          --     settings = {
          --       gopls = {
          --         analyses = {
          --           unusedparams = true,
          --         },
          --       },
          --     },
          --   })
          -- end,
        },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
