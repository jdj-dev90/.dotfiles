return {
	{ "<leader>t", group = "Terminal", nowait = true, remap = false },
	{
		"<leader>td",
		function()
			_LAZYDOCKER_TOGGLE()
		end,
		desc = "Docker",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tf",
		function()
			vim.api.nvim_cmd({ cmd = "ToggleTerm", args = { "direction=float" } }, {})
		end,
		desc = "Float",
		nowait = true,
		remap = false,
	},
	{
		"<leader>th",
		function()
			vim.fn.system({ "tmux", "split-window", "-h", "-b" })
		end,
		desc = "Split Left",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tj",
		function()
			vim.fn.system({ "tmux", "split-window", "-v" })
		end,
		desc = "Split Down",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tk",
		function()
			vim.fn.system({ "tmux", "split-window", "-v", "-b" })
		end,
		desc = "Split Up",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tl",
		function()
			vim.cmd("vsplit | terminal")
			vim.cmd("startinsert")
		end,
		desc = "Split Right (Terminal)",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tn",
		function()
			_LAZYNPM_TOGGLE()
		end,
		desc = "NPM",
		nowait = true,
		remap = false,
	},
	{
		"<leader>to",
		function()
			_NODE_TOGGLE()
		end,
		desc = "Node",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tp",
		function()
			_PYTHON_TOGGLE()
		end,
		desc = "Python",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tt",
		function()
			_HTOP_TOGGLE()
		end,
		desc = "Htop",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tu",
		function()
			_NCDU_TOGGLE()
		end,
		desc = "NCDU",
		nowait = true,
		remap = false,
	},
}
