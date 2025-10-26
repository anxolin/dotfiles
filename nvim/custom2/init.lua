
-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- **********************************************
--            Leader Keys (must be before lazy)
-- **********************************************
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- **********************************************
--            Bootstrap lazy.nvim
-- **********************************************
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- **********************************************
--            Load Plugins
-- **********************************************
require("lazy").setup("plugins", {
  defaults = {
    lazy = false, -- plugins are loaded during startup by default
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- don't notify on every check
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- **********************************************
--            Config
-- **********************************************
-- Equivalent to Vim's set. Example
--   set number
--   set clipboard=unnamedplus
-- See https://neovim.io/doc/user/options.html#'number'
local opt = vim.opt
opt.number = true -- Print the line number in front of each line
opt.wrap = false -- lines longer than the width of the window will wrap and displaying continues on the next line
opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line
opt.signcolumn = "yes" -- When and how to draw the signcolumn (yes = always)
opt.mouse = "a" -- Mouse for all modes (normal, visual, insert, ...)
opt.clipboard = "unnamedplus" -- A variant of the "unnamed" flag which uses the clipboard register "+"
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper
opt.splitright = true -- When on, splitting a window will put the new window right of the current one
opt.splitbelow = true -- When on, splitting a window will put the new window below the current one
opt.termguicolors = true -- Enables 24-bit RGB color in the TUI (Requires an ISO-8613-3 compatible terminal)
opt.updatetime = 200 -- If this many milliseconds nothing is typed the swap file will be written to disk
opt.timeoutlen = 400 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 5 -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.

-- Indentation settings - use spaces instead of tabs
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
opt.smartindent = true -- Insert indents automatically


-- **********************************************
--            Mappings (Vim.keymap.set)
-- **********************************************
-- Equivalent to Vimscripts:
--   nnoremap <leader>w :w<CR>

--Basic keymaps (tiny, discoverable)
local map = vim.keymap.set
local silent = { silent = true, noremap = true }

-- Saving / quitting
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>",  { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>",   { desc = "Quit all (force)" })

-- Better window moves with Ctrl-h/j/k/l
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)

-- Clear search highlights quickly
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })


-- **********************************************
--            Auto-commands (vim.api.nvim_create_autocmd)
-- **********************************************

-- Small quality-of-life autocommands
local aug = vim.api.nvim_create_augroup -- Create or get an autocommand group autocmd-groups. See https://neovim.io/doc/user/autocmd.html#autocmd-groups
local ac  = vim.api.nvim_create_autocmd -- Creates an autocommand event handler, defined by callback (Lua function or Vimscript function name string) or command (Ex command string).. See https://neovim.io/doc/user/api.html#nvim_create_autocmd() 

-- Highlight on yank
aug("YankHighlight", { clear = true })
ac("TextYankPost", {
  group = "YankHighlight",
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 }) end,
})

-- Restore cursor position when reopening a file
aug("LastPosition", { clear = true })
ac("BufReadPost", {
  group = "LastPosition",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- **********************************************
--            Custom commands (vim.api.nvim_create_user_command)
-- **********************************************

-- defines a new command :Reload which Saves the current file and re-runs init.lua file
vim.api.nvim_create_user_command("Reload", function()
  vim.cmd("write")
  dofile(vim.env.MYVIMRC)
  print("~/.config/nvim/init.lua reloaded")
end, {})

-- Friendly message at startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      print("✨ Custom Neovim config with lazy.nvim loaded!")
      print("💡 Press <Space> to see keybindings")
    end, 50)
  end,
})

