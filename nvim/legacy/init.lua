
-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- Leader keys first
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Reuse your existing Vim config during the transition
-- Make your old ~/.vim and ~/.vimrc visible to Neovim
local home = vim.fn.expand("~")
local rtp = vim.opt.rtp:get()
table.insert(rtp, 1, home .. "/.vim")
table.insert(rtp, home .. "/.vim/after")
vim.opt.rtp = rtp
vim.o.packpath = vim.o.runtimepath
local vimrc = home .. "/.vimrc"
if vim.fn.filereadable(vimrc) == 1 then
  -- Source vimrc with error handling for missing colorschemes
  local ok, err = pcall(vim.cmd.source, vimrc)
  if not ok then
    vim.notify("Error loading .vimrc: " .. err, vim.log.levels.WARN)
  end
end

-- Basic quality-of-life in Lua (safe even if your .vimrc sets similar things)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 200
vim.opt.splitright = true
vim.opt.splitbelow = true

-- A couple Lua-native keymaps (example)
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>",  { desc = "Quit" })

-- 4) Check your environment
-- Run :checkhealth after first launch to spot missing deps

