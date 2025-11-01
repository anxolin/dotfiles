-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- **********************************************
--            Globals (vim.g)
-- **********************************************
-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Disable unused providers (removes warnings from :checkhealth)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- **********************************************
--            Plugins
-- **********************************************
require("config.lazy") -- Lazy.nvim (see nvim/custom/lua/config/lazy.lua)

-- **********************************************
--            Config
-- **********************************************
-- Equivalent to Vim's set. Example
--   set number
--   set clipboard=unnamedplus
-- See https://neovim.io/doc/user/options.html#'number'
local opt = vim.opt
opt.number = true -- Print the line number in front of each line
opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line
opt.wrap = false -- lines longer than the width of the window will wrap and displaying continues on the next line
opt.signcolumn = "yes" -- When and how to draw the signcolumn (yes = always)
opt.mouse = "a" -- Mouse for all modes (normal, visual, insert, ...)
opt.clipboard = "unnamedplus" -- A variant of the "unnamed" flag which uses the clipboard register "+"
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper
opt.splitright = true -- When on, splitting a window will put the new window right of the current one
opt.splitbelow = true -- When on, splitting a window will put the new window below the current one
opt.termguicolors = true -- Enables 24-bit RGB color in the TUI (Requires an ISO-8613-3 compatible terminal)
opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 5 -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
opt.cursorline = true -- Highlight the current line
-- opt.confirm = true            -- Instead of failing when performing a command like :q with unsaved changes, ask to safe

-- Indentation settings - use spaces instead of tabs
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
opt.smartindent = true -- Insert indents automatically

-- Make nvim a bit more responsive
opt.timeout = true -- This option and 'timeoutlen' determine the behavior when
opt.ttimeout = true --  This option and 'ttimeoutlen' determine the behavior when part of a key code sequence has been received by the TUI
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.ttimeoutlen = 10 -- Time in milliseconds to wait for a key code sequence to complete.
opt.lazyredraw = true -- When this option is set, the screen will not be redrawn while executing macros, registers and other commands that have not been typed
opt.cursorcolumn = false
-- optional; toggle cursorline only when you need it
-- opt.nocursorline
opt.updatetime = 200 -- If this many milliseconds nothing is typed the swap file will be written to disk

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
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Navigate between windows with Alt-h/j/k/l in any mode
map({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h")
map({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j")
map({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k")
map({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l")
map({ "n" }, "<A-h>", "<C-w>h")
map({ "n" }, "<A-j>", "<C-w>j")
map({ "n" }, "<A-k>", "<C-w>k")
map({ "n" }, "<A-l>", "<C-w>l")

-- Tab navigation with Leader+arrows
map("n", "<leader><Left>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader><Right>", "<cmd>tabnext<cr>", { desc = "Next tab" })
-- Tab navigation with Leader+h/l as fallback
map("n", "<leader>h", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader>l", "<cmd>tabnext<cr>", { desc = "Next tab" })
-- Tab navigation with Alt+Tab (may not work in all terminals/OS)
map("n", "<A-Tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<M-C-Y>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
-- Tab navigation with Alt+[ and Alt+]
map("n", "<A-]>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<A-[>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Clear search highlights quickly
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- **********************************************
--            Auto-commands (vim.api.nvim_create_autocmd)
-- **********************************************

-- Small quality-of-life autocommands
local aug = vim.api.nvim_create_augroup -- Create or get an autocommand group autocmd-groups. See https://neovim.io/doc/user/autocmd.html#autocmd-groups
local ac = vim.api.nvim_create_autocmd -- Creates an autocommand event handler, defined by callback (Lua function or Vimscript function name string) or command (Ex command string).. See https://neovim.io/doc/user/api.html#nvim_create_autocmd()

-- Highlight on yank
aug("YankHighlight", { clear = true })
ac("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 })
	end,
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
--            Commands (vim.api.nvim_create_user_command)
-- **********************************************

-- Reload: which Saves the current file and re-runs init.lua file
vim.api.nvim_create_user_command("Reload", function()
	vim.cmd("write")
	dofile(vim.env.MYVIMRC)
	print("~/.config/nvim/init.lua reloaded")
end, {})

-- Show what Neovim sees
-- vim.notify("You pressed: " .. vim.inspect(key), vim.log.levels.INFO)

-- WhichKeyStroke: Allows to reveal which command corresponds with a given keystroke
-- then paste the snippet at top level:
vim.api.nvim_create_user_command("WhichKeyStroke", function()
	vim.notify("Press a key...", vim.log.levels.INFO)
	local ok, key = pcall(vim.fn.getcharstr)
	if not ok then
		return
	end

	local special = vim.fn.keytrans(key)
	vim.notify("You pressed: " .. special, vim.log.levels.INFO)

	local maps = vim.keymap.get("n", special)
	if not maps or #maps == 0 then
		vim.notify("No mapping found for " .. special, vim.log.levels.WARN)
		return
	end

	for _, map in ipairs(maps) do
		local rhs = map.rhs or "[builtin]"
		local desc = map.desc and (" — " .. map.desc) or ""
		local src = map.buffer and " (buffer-local)" or ""
		vim.notify(string.format("%s → %s%s%s", map.lhs, rhs, desc, src))
	end
end, { desc = "Press a key and show its mapping" })

-- **********************************************
--            Auto-commands ()
-- **********************************************
-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
--vim.api.nvim_create_autocmd('TextYankPost', {
--  desc = 'Highlight when yanking (copying) text',
--  callback = function()
--    vim.hl.on_yank()
--  end,
--})
