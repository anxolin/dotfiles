return {

  -- Which-key: Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- See config https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }

}