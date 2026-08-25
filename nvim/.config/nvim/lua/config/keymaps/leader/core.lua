return {
	{
		"<leader>b",
		function()
			require("telescope.builtin").buffers()
		end,
		desc = "Buffers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>cc",
		function()
			vim.api.nvim_buf_delete(0, { force = true })
		end,
		desc = "Close Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>e",
		function()
			MiniFiles.open(vim.api.nvim_buf_get_name(0))
		end,
		desc = "Explorer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>q",
		function()
			vim.api.nvim_cmd({ cmd = "q!" }, {})
		end,
		desc = "Quit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>w",
		function()
			vim.api.nvim_cmd({ cmd = "w!" }, {})
		end,
		desc = "Save",
		nowait = true,
		remap = false,
	},
}
