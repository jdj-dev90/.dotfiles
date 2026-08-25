local M = {}

local root_markers = {
	".git",
	"go.mod",
	"go.work",
	"package.json",
	"pyproject.toml",
	"Cargo.toml",
	"Makefile",
	"justfile",
}

function M.root(bufnr)
	bufnr = bufnr or 0
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == nil or name == "" then
		return vim.loop.cwd()
	end
	local root = vim.fs.root(name, root_markers)
	if root then
		return root
	end
	return vim.fs.dirname(name)
end

return M
