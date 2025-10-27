-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim


return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Optional: tweak signs; ASCII works without Nerd Fonts
      -- signs = {
      --   add          = { text = "+" },
      --   change       = { text = "~" },
      --   delete       = { text = "-" },
      --   topdelete    = { text = "‾" },
      --   changedelete = { text = "±" },
      --   untracked    = { text = "?" },
      -- },
      --current_line_blame = true, -- toggle per buffer with :Gitsigns toggle_current_line_blame
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      local gs = require("gitsigns")
      -- Handy keymaps
      vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next hunk" })
      vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
      vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    end,
  },


  -- Neogit: Magit-like git interface for Neovim
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",           -- required
      "sindrets/diffview.nvim",          -- optional - Diff integration
      "nvim-telescope/telescope.nvim",   -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>",        desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
    },
    opts = {
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
  },
}
