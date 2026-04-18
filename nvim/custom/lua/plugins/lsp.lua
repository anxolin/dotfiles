-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim


-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim",                tag = "legacy", opts = {} },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "stevearc/conform.nvim" },
    },
    config = function()
      --------------------------------------------------------------------------
      -- Mason
      --------------------------------------------------------------------------
      require("mason").setup()

      --------------------------------------------------------------------------
      -- nvim-cmp
      --------------------------------------------------------------------------
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
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
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "path", group_index = 2 },
        },
      })

      -- Capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then capabilities = cmp_lsp.default_capabilities(capabilities) end

      --------------------------------------------------------------------------
      -- Keymaps on attach
      --------------------------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          --local bufnr = args.buf
          --local map = function(m, lhs, rhs, desc)
          --  vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          --end

          -- Telescope-based LSP navigation (better UI)
          --local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
          --if telescope_ok then
          -- NOTE: Disabled because I use the ones in snack.lua
          --map("n", "gd", telescope_builtin.lsp_definitions, "Goto Definition")
          --map("n", "gr", telescope_builtin.lsp_references, "References")
          --map("n", "gi", telescope_builtin.lsp_implementations, "Goto Implementation")
          --map("n", "<leader>fs", telescope_builtin.lsp_document_symbols, "Document Symbols")
          --map("n", "<leader>fS", telescope_builtin.lsp_workspace_symbols, "Workspace Symbols")
          --map("n", "<leader>fd", telescope_builtin.diagnostics, "Diagnostics")
          --else
          -- Fallback to built-in LSP if Telescope not available
          --map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
          --map("n", "gr", vim.lsp.buf.references, "References")
          --map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
          -- end

          -- Non-Telescope LSP mappings
          --map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          --map("n", "K", vim.lsp.buf.hover, "Hover")
          --map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          --map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          --map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          --map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
          --map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "Format")
        end,
      })

      --------------------------------------------------------------------------
      -- LSP servers via mason-lspconfig (NEW handlers API)
      --------------------------------------------------------------------------
      local lspconfig = require("lspconfig")

      local ensure_installed = {
        "lua_ls",        -- Lua Language Server
        "gopls",         -- Go Language Server
        "rust_analyzer", -- Rust Language Server
      }
      -- npm-based servers: only auto-install when npm is on PATH
      if vim.fn.executable("npm") == 1 then
        vim.list_extend(ensure_installed, {
          "pyright",     -- Python Language Server (npm)
          "ts_ls",       -- TypeScript/JavaScript Language Server (npm)
          "solidity_ls", -- Solidity Language Server via vscode-solidity-server (npm)
        })
      end

      require("mason-lspconfig").setup({
        -- If your setup is older, and "ts_ls" isn't recognized, switch to "tsserver".
        -- To check the list of available LSP servers. Check :Mason
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          -- default handler for all servers
          function(server)
            lspconfig[server].setup({ capabilities = capabilities })
          end,

          -- per-server tweaks
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })

      --------------------------------------------------------------------------
      -- Diagnostics UI
      --------------------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        float = { border = "rounded" },
        severity_sort = true,
        update_in_insert = false,
      })

      --------------------------------------------------------------------------
      -- Conform (formatting)
      --------------------------------------------------------------------------
      require("conform").setup({
        format_on_save = { lsp_fallback = true, timeout_ms = 2000 },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          go = { "gofmt" },
          rust = { "rustfmt" },
        },
      })
    end,
  },
}
