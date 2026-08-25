return {
	{ "<leader>l", group = "LSP", nowait = true, remap = false },
	{
		"<leader>lI",
		function()
			vim.api.nvim_cmd({ cmd = "LspInstallInfo" }, {})
		end,
		desc = "Installer Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lS",
		function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end,
		desc = "Workspace Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ld",
		function()
			require("telescope.builtin").lsp_document_diagnostics()
		end,
		desc = "Document Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lf",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		desc = "Format",
		nowait = true,
		remap = false,
	},
	{
		"<leader>li",
		function()
			vim.api.nvim_cmd({ cmd = "LspInfo" }, {})
		end,
		desc = "Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lj",
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "Next Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lk",
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "Prev Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ll",
		function()
			vim.lsp.codelens.run()
		end,
		desc = "CodeLens Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lq",
		function()
			vim.diagnostic.set_loclist()
		end,
		desc = "Quickfix",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lr",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "Rename",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ls",
		function()
			require("telescope.builtin").lsp_document_symbols()
		end,
		desc = "Document Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lw",
		function()
			require("telescope.builtin").lsp_workspace_diagnostics()
		end,
		desc = "Workspace Diagnostics",
		nowait = true,
		remap = false,
	},
}
