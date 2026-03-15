local M = {}

function M.live_grep_by_ext()
	local ok, builtin = pcall(require, "telescope.builtin")
	if not ok then
		return
	end

	local ext = vim.fn.input("Extension: ")
	if ext == nil or ext == "" then
		return
	end

	ext = ext:gsub("^%.", "")

	builtin.live_grep({
		glob_pattern = "*." .. ext,
		prompt_title = "Live Grep *." .. ext,
	})
end

return M
