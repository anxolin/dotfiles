-- Which-key: Shows pending keybindings in a popup
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        spelling = { enabled = true },
      },
    })

    -- Document existing key chains
    wk.add({
      { "<leader>w", desc = "Write file" },
      { "<leader>q", desc = "Quit" },
      { "<leader>Q", desc = "Quit all (force)" },
    })
  end,
}
