local enabled = false

return {
	{
		"zbirenbaum/copilot.lua",
		enabled = enabled,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = false, -- Disable default Tab mapping
						accept_word = false,
						accept_line = false,
						next = "<A-n>",
						prev = "<A-p>",
						dismiss = "<C-m>",
					},
				},
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})

			-- Smart Tab mapping: accept Copilot suggestion if available, otherwise insert tab/indent
			local function smart_tab()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end

			vim.keymap.set("i", "<Tab>", smart_tab, { silent = true, desc = "Smart Tab (Copilot or indent)" })
			vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true, desc = "Unindent" })
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = enabled,
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
