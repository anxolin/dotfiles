-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
	-- Telescope: Fuzzy search
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- See https://github.com/nvim-telescope/telescope.nvim/releases
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
							-- Switch between pickers
							["<C-g>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								vim.schedule(function()
									builtin.live_grep()
								end)
							end,
							["<C-p>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								vim.schedule(function()
									builtin.find_files()
								end)
							end,
						},
						n = {
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
							-- Switch between pickers
							["<C-g>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								vim.schedule(function()
									builtin.live_grep()
								end)
							end,
							["<C-p>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								vim.schedule(function()
									builtin.find_files()
								end)
							end,
						},
					},
				},
				pickers = {
					buffers = {
						mappings = {
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},
				},
			})

			-- Telescope keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

			-- Ctrl-P opens Snacks smart search
			vim.keymap.set("n", "<C-p>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
			-- Ctrl-P as alternative to <leader>ff (Telescope)
			-- vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
		end,
	},
}
