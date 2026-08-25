local function strip_leading_blank_lines()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local first = 1
	while first <= #lines and lines[first] == "" do
		first = first + 1
	end
	if first > 1 then
		vim.api.nvim_buf_set_lines(0, 0, first - 1, false, {})
	end
end

local function apply_template(name)
	vim.api.nvim_cmd({ cmd = "ObsidianTemplate", args = { name } }, {})
	strip_leading_blank_lines()
end

return {
	{ "<leader>o", group = "Obsidian", nowait = true, remap = false },
	{
		mode = { "n", "v" },
		{
			"<leader>od",
			function()
				local file = vim.api.nvim_buf_get_name(0)
				if file == nil or file == "" then
					return
				end
				vim.fn.delete(file)
				vim.api.nvim_buf_delete(0, { force = true })
			end,
			desc = "Delete Note",
			nowait = true,
			remap = false,
		},
		{
			"<leader>of",
			function()
				local dir = vim.fn.expand("$SECOND_BRAIN/notes")
				require("telescope.builtin").find_files({ search_dirs = { dir } })
			end,
			desc = "Search SB Files",
			nowait = true,
			remap = false,
		},
		{
			"<leader>ok",
			function()
				local file = vim.api.nvim_buf_get_name(0)
				if file == nil or file == "" then
					return
				end
				local target_dir = vim.fn.expand("$SECOND_BRAIN/zettelkasten")
				if target_dir == "" then
					return
				end
				local target = target_dir .. "/" .. vim.fn.fnamemodify(file, ":t")
				vim.fn.rename(file, target)
				vim.api.nvim_buf_delete(0, { force = true })
			end,
			desc = "Accept Note",
			nowait = true,
			remap = false,
		},
		{
			"<leader>on",
			function()
				vim.api.nvim_cmd({ cmd = "ObsidianNew" }, {})
			end,
			desc = "New Note",
			nowait = true,
			remap = false,
		},
		{
			"<leader>oo",
			function()
				local dir = vim.fn.expand("$SECOND_BRAIN")
				if dir == nil or dir == "" then
					return
				end
				vim.api.nvim_set_current_dir(dir)
			end,
			desc = "Navigate To Vault",
			nowait = true,
			remap = false,
		},
		{
			"<leader>os",
			function()
				local dir = vim.fn.expand("$SECOND_BRAIN/notes")
				require("telescope.builtin").live_grep({ search_dirs = { dir } })
			end,
			desc = "Grep SB",
			nowait = true,
			remap = false,
		},
		{
			"<leader>otn",
			function()
				apply_template("note")
			end,
			desc = "Note Template",
			nowait = true,
			remap = false,
		},
		{
			"<leader>ots",
			function()
				apply_template("uni-subject")
			end,
			desc = "Uni-Subject Template",
			nowait = true,
			remap = false,
		},
		{
			"<leader>otu",
			function()
				apply_template("uni-note")
			end,
			desc = "Uni-Note Template",
			nowait = true,
			remap = false,
		},
		{
			"<leader>ox",
			function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				for i, line in ipairs(lines) do
					if line:match("^# ") then
						line = line:gsub("-", " ")
						line = line:gsub("_", " - ")
						lines[i] = line
					end
				end
				vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			end,
			desc = "Fix Title",
			nowait = true,
			remap = false,
		},
	},
}
