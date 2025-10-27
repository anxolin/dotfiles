-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim


return {
  {
    -- Define custom buffer commands
    -- This is not actually a plugin, just a way to organize buffer-related configs
    dir = vim.fn.stdpath("config"),
    config = function()
      -- BufOnly: Close all buffers except the current one
      vim.api.nvim_create_user_command("BufOnly", function()
        vim.cmd("%bd|e#")
      end, {
        desc = "Close all buffers except current",
      })
    end,
  },
}
