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
					path_display = { "filename_first" },
					dynamic_preview_title = true,
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.95,
						height = 0.95,
						preview_width = 0.55,
					},
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

			-- Ctrl-P opens Snacks smart search
			vim.keymap.set("n", "<C-p>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
		end,
	},
}
