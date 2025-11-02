return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- Smart JSX/TSX commenting
		},
		config = function()
			require("Comment").setup({
				-- Enable treesitter integration for context-aware commenting
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false, -- Let Comment.nvim handle it
		},
	},
}
