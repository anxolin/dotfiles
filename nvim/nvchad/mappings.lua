---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- Lazygit
    ["<leader>lg"] = {
      function()
        require("lazygit").lazygit()
      end,
      "lazygit",
    }

  },
  v = {
    [">"] = { ">gv", "indent"},
  },


}

-- more keybinds!

return M
