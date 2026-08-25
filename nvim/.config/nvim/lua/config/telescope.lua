local M = {}

local function get_builtin()
	local ok, builtin = pcall(require, "telescope.builtin")
	if not ok then
		return nil
	end
	return builtin
end

local function with_root(opts)
	local project = require("config.project")
	return vim.tbl_extend("force", { cwd = project.root() }, opts or {})
end

function M.find_files()
	local builtin = get_builtin()
	if not builtin then
		return
	end
	builtin.find_files(with_root())
end

function M.live_grep()
	local builtin = get_builtin()
	if not builtin then
		return
	end
	builtin.live_grep(with_root())
end

function M.grep_string()
	local builtin = get_builtin()
	if not builtin then
		return
	end
	builtin.grep_string(with_root())
end

function M.live_grep_by_ext()
	local builtin = get_builtin()
	if not builtin then
		return
	end

	local ext = vim.fn.input("Extension: ")
	if ext == nil or ext == "" then
		return
	end

	ext = ext:gsub("^%.", "")

	builtin.live_grep(with_root({
		glob_pattern = "*." .. ext,
		prompt_title = "Live Grep *." .. ext,
	}))
end

return M
