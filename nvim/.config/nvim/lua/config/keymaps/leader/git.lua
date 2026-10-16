return {
	{ "<leader>g", group = "Git", nowait = true, remap = false },
	{
		"<leader>gD",
		function()
			vim.api.nvim_cmd({ cmd = "DiffviewOpen", args = { "origin/main...HEAD" } }, {})
		end,
		desc = "Diffview branch vs origin/main",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gL",
		function()
			vim.api.nvim_cmd({ cmd = "Neogit", args = { "log" } }, {})
		end,
		desc = "Log",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gP",
		function()
			vim.api.nvim_cmd({ cmd = "Neogit", args = { "push" } }, {})
		end,
		desc = "Push",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gR",
		function()
			require("gitsigns").reset_buffer()
		end,
		desc = "Reset Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gb",
		function()
			require("telescope.builtin").git_branches()
		end,
		desc = "Checkout branch",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gc",
		function()
			require("telescope.builtin").git_commits()
		end,
		desc = "Checkout commit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gdc",
		function()
			vim.api.nvim_cmd({ cmd = "DiffviewClose" }, {})
		end,
		desc = "Diffview Close",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gdo",
		function()
			vim.api.nvim_cmd({ cmd = "DiffviewOpen" }, {})
		end,
		desc = "Diffview Open",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gg",
		function()
			vim.api.nvim_cmd({ cmd = "Neogit" }, {})
		end,
		desc = "Neogit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gj",
		function()
			require("gitsigns").next_hunk()
		end,
		desc = "Next Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gk",
		function()
			require("gitsigns").prev_hunk()
		end,
		desc = "Prev Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gl",
		function()
			require("gitsigns").blame_line()
		end,
		desc = "Blame",
		nowait = true,
		remap = false,
	},
	{
		"<leader>go",
		function()
			require("telescope.builtin").git_status()
		end,
		desc = "Open changed file",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gp",
		function()
			require("gitsigns").preview_hunk()
		end,
		desc = "Preview Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gr",
		function()
			require("gitsigns").reset_hunk()
		end,
		desc = "Reset Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gs",
		function()
			require("gitsigns").stage_hunk()
		end,
		desc = "Stage Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gu",
		function()
			require("gitsigns").undo_stage_hunk()
		end,
		desc = "Undo Stage Hunk",
		nowait = true,
		remap = false,
	},
}
