return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true, prefer_git = true })
		end,
		config = function()
			-- Map gotmpl filetype to use Go template parser
			vim.treesitter.language.register('gotmpl', 'gotmpl')

			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "typescript", "javascript", "c", "go", "gotmpl", "templ" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
				sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
				ignore_install = { "" }, -- List of parsers to ignore installing
				autopairs = {
					enable = true,
				},
				highlight = {
					enable = true, -- false will disable the whole extension
					disable = { "" }, -- list of language that will be disabled
					additional_vim_regex_highlighting = true,
				},
				indent = { enable = true, disable = { "yaml" } },
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			--- 'windwp/nvim-ts-autotag',
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({ min_window_height = 30 })
				end,
			},

			"JoosepAlviste/nvim-ts-context-commentstring",
			---'nvim-treesitter/playground',
			---'RRethy/nvim-treesitter-textsubjects',
		},
	},
}
