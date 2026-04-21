-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim


return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          position = "float",
          mappings = {
            h = "close_node",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            show_hidden_count = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = {
              ".git",
              ".nvim",
              "node_modules",
              ".history",
            },
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
        buffers = { follow_current_file = { enable = true } },
      })

      -- 🗂️ Toggle the file tree with <leader>e and <C-n>
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle reveal<cr>", { desc = "Toggle Neo-tree" })
      vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle reveal<cr>", { desc = "Toggle Neo-tree" })
    end,
  }

}
