return {

	-- treesitter: Parses the code for better syntax and navigation,
	--   Uses Language parsers, installed with :TSInstall <language_to_install>
	--   You can also get a list of all available languages and their installation status with :TSInstallInfo
	--   See supported languages https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
	--   use :TSUpdate {language}. To update all parsers unconditionally
	--   use :TSUpdate all or just :TSUpdate to update all languages
	--NOTE: This plugin servers a different porpouse than the ones in LSP, this one is about parsing for syntax and navigation, LSP is about connecting to a LSP and offering
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		-- event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Install parsers for these languages
				--   * Languages: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"tsx",
					"python",
					"jinja",
					"rust",
					"go",
					"html",
					"css",
					"json",
					"yaml",
					"markdown",
					"markdown_inline",
					"bash",
					"solidity",
					"sql",
					"xml",
					"styled",
					"regex",
					"scss",
					"svelte",
					"typst",
					"vue",
					"mermaid",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true,
				},

				-- Incremental selection based on syntax
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<S-CR>",
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
}
