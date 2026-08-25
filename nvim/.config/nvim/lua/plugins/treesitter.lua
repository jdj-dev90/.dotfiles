return {
	{
		"neovim-treesitter/nvim-treesitter",
		lazy = false,
		cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSStatus", "TSRegistryUpdate" },
		build = ":TSUpdate",
		config = function()
			vim.treesitter.language.register("gotmpl", "gotmpl")
			local ts = require("nvim-treesitter")
			local languages = { "lua", "typescript", "javascript", "c", "go", "gotmpl", "templ", "markdown", "markdown_inline" }
			local ts_bin = vim.fn.exepath("tree-sitter")
			if ts_bin == "" and vim.uv.fs_stat("/usr/bin/tree-sitter") then
				vim.env.PATH = "/usr/bin:" .. vim.env.PATH
				ts_bin = "/usr/bin/tree-sitter"
			end

			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			if ts_bin ~= "" then
				ts.install(languages)
			else
				vim.schedule(function()
					vim.notify_once("nvim-treesitter: install tree-sitter CLI (Arch: sudo pacman -S tree-sitter-cli)", vim.log.levels.WARN)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					if vim.bo[args.buf].filetype ~= "yaml" then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
		dependencies = {
			"neovim-treesitter/treesitter-parser-registry",
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						min_window_height = 30,
					})
				end,
			},

			---'nvim-treesitter/playground',
			---'RRethy/nvim-treesitter-textsubjects',
		},
	},
}
