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
			-- Compat shim: nvim-treesitter master branch doesn't support nvim 0.12
			-- (see its README). On 0.12, query directive handlers receive `match[id]`
			-- as a list of nodes (TSNode[]) instead of a single node, which makes the
			-- plugin's directives crash with "attempt to call method 'range' (a nil value)"
			-- when treesitter calls get_node_text on the list.
			-- We re-register the affected directives to unwrap the list before use.
			if vim.fn.has("nvim-0.12") == 1 then
				local tsq = require("vim.treesitter.query")
				local alias_map = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }
				local html_script_type_languages = {
					importmap = "json",
					module = "javascript",
					["application/ecmascript"] = "javascript",
					["text/ecmascript"] = "javascript",
				}
				local function unwrap(match, capture_id)
					local v = match[capture_id]
					if type(v) == "table" then return v[1] end
					return v
				end

				tsq.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
					local node = unwrap(match, pred[2])
					if not node then return end
					local alias = vim.treesitter.get_node_text(node, bufnr):lower()
					local ft = vim.filetype.match({ filename = "a." .. alias })
					metadata["injection.language"] = ft or alias_map[alias] or alias
				end, { force = true })

				tsq.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
					local node = unwrap(match, pred[2])
					if not node then return end
					local value = vim.treesitter.get_node_text(node, bufnr)
					local configured = html_script_type_languages[value]
					if configured then
						metadata["injection.language"] = configured
					else
						local parts = vim.split(value, "/", {})
						metadata["injection.language"] = parts[#parts]
					end
				end, { force = true })

				tsq.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
					local id = pred[2]
					local node = unwrap(match, id)
					if not node then return end
					local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
					metadata[id] = metadata[id] or {}
					metadata[id].text = string.lower(text)
				end, { force = true })
			end

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
