-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- Catppuccin flavor follows the system theme (or the ~/dotfiles/scripts/theme-mode
-- override). Switch with :ThemeLight / :ThemeDark / :ThemeAuto / :ThemeToggle,
-- or run `theme toggle` from any shell — nvim watches the event file and reloads.

local SCRIPT = vim.fn.expand("~/dotfiles/scripts/theme-mode")
local STATE_DIR = vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state")
local EVENT_FILE = STATE_DIR .. "/theme-mode.event"

local function read_mode()
  local ok, out = pcall(vim.fn.system, SCRIPT)
  if not ok then return "dark" end
  out = vim.fn.trim(out or "")
  if out == "light" then return "light" end
  return "dark"
end

local function apply(mode)
  if mode == "light" then
    vim.o.background = "light"
    vim.cmd.colorscheme("catppuccin-latte")
  else
    vim.o.background = "dark"
    vim.cmd.colorscheme("catppuccin-mocha")
  end
end

local function watch_event_file()
  vim.fn.mkdir(STATE_DIR, "p")
  if vim.fn.filereadable(EVENT_FILE) == 0 then
    vim.fn.writefile({}, EVENT_FILE)
  end
  -- fs_poll re-arms automatically and works across platforms (fs_event on
  -- macOS only fires once per registration).
  local poll = vim.uv.new_fs_poll()
  if poll then
    poll:start(EVENT_FILE, 2000, vim.schedule_wrap(function(err)
      if not err then apply(read_mode()) end
    end))
  end
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- pick latte/mocha based on vim.o.background
        background = { light = "latte", dark = "mocha" },
      })

      apply(read_mode())

      vim.api.nvim_create_user_command("ThemeLight", function()
        vim.fn.system({ SCRIPT, "set", "light" }); apply("light")
      end, { desc = "Force light mode" })
      vim.api.nvim_create_user_command("ThemeDark", function()
        vim.fn.system({ SCRIPT, "set", "dark" }); apply("dark")
      end, { desc = "Force dark mode" })
      vim.api.nvim_create_user_command("ThemeAuto", function()
        vim.fn.system({ SCRIPT, "set", "auto" }); apply(read_mode())
      end, { desc = "Follow OS appearance" })
      vim.api.nvim_create_user_command("ThemeToggle", function()
        vim.fn.system({ SCRIPT, "toggle" }); apply(read_mode())
      end, { desc = "Toggle light/dark" })
      vim.api.nvim_create_user_command("ThemeReload", function()
        apply(read_mode())
      end, { desc = "Re-read theme from disk" })

      watch_event_file()
    end,
  },
}
