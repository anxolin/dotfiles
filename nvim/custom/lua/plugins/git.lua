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
      vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      vim.keymap.set("n", "<leader>gD", gs.diffthis, { desc = "Diff file" })
    end,
  },


  -- Neogit: Magit-like git interface for Neovim
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>",             desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>",      desc = "Neogit commit" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",       desc = "Git diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo history" },
      { "<leader>gP", "<cmd>Neogit push<cr>",        desc = "Git push" },
      { "<leader>gl", "<cmd>Neogit log<cr>",         desc = "Git log" },
    },
    opts = {
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
  },

  -- Blame: Fugitive style git blame
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}

      vim.api.nvim_create_user_command("ToggleBlame", function(args)
        require("blame").toggle(args)
      end, { nargs = "*" })

      vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>", { desc = "Git blame" })
    end,
    opts = {
      blame_options = { '-w' },
    },
  },
}
