return {
	{
		"<leader>b",
		"<cmd>Telescope buffers<cr>",
		desc = "Buffers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>cc",
		"<cmd>bdelete!<CR>",
		desc = "Close Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>e",
		"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
		desc = "Explorer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>q",
		"<cmd>q!<CR>",
		desc = "Quit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>w",
		"<cmd>w!<CR>",
		desc = "Save",
		nowait = true,
		remap = false,
	},
}
