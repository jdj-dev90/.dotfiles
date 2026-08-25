local M = {}

local function map_entry(entry, parent_mode)
	if type(entry) ~= "table" then
		return
	end
	if entry.group then
		return
	end
	if entry.mode and type(entry[1]) == "table" then
		for i = 1, #entry do
			map_entry(entry[i], entry.mode)
		end
		return
	end
	if type(entry[1]) ~= "string" then
		return
	end
	local lhs = entry[1]
	local rhs = entry[2]
	if rhs == nil then
		return
	end
	local mode = entry.mode or parent_mode or "n"
	local opts = {
		desc = entry.desc,
		nowait = entry.nowait,
		remap = entry.remap or false,
		silent = entry.silent ~= false,
	}
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.apply(mappings)
	for _, entry in ipairs(mappings or {}) do
		map_entry(entry, nil)
	end
end

return M
