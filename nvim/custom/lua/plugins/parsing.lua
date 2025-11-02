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

				-- Textobjects for navigation and selection
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- Add to jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.inner",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
