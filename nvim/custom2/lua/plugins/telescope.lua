-- Telescope: Fuzzy finder for files, buffers, etc.
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    -- File pickers
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },

    -- LSP pickers (symbol navigation with nice UI)
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
    { "<leader>fR", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
    { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementation" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
        file_ignore_patterns = { "node_modules", ".git/" },
      },
    })

    -- Load fzf extension for better performance
    telescope.load_extension("fzf")
  end,
}
