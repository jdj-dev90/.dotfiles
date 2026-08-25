return {
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{
		"<leader>sC",
		function()
			require("telescope.builtin").commands()
		end,
		desc = "Commands",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sM",
		function()
			require("telescope.builtin").man_pages()
		end,
		desc = "Man Pages",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sR",
		function()
			require("telescope.builtin").registers()
		end,
		desc = "Registers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sb",
		function()
			require("telescope.builtin").git_branches()
		end,
		desc = "Checkout branch",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sc",
		function()
			require("telescope.builtin").colorscheme()
		end,
		desc = "Colorscheme",
		nowait = true,
		remap = false,
	},
	{
		"<leader>se",
		function()
			require("config.telescope").live_grep_by_ext()
		end,
		desc = "Grep by Ext",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sf",
		function()
			require("config.telescope").find_files()
		end,
		desc = "Find Files",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sh",
		function()
			require("telescope.builtin").help_tags()
		end,
		desc = "Find Help",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sk",
		function()
			require("telescope.builtin").keymaps()
		end,
		desc = "Keymaps",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sr",
		function()
			require("telescope.builtin").oldfiles()
		end,
		desc = "Open Recent File",
		nowait = true,
		remap = false,
	},
	{
		"<leader>su",
		function()
			require("config.telescope").grep_string()
		end,
		desc = "Search Text Under Cursor",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sw",
		function()
			require("config.telescope").live_grep()
		end,
		desc = "Find Text",
		nowait = true,
		remap = false,
	},
}
