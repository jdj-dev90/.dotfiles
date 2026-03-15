local mappings = {}

local groups = {
	"core",
	"dap",
	"git",
	"lsp",
	"search",
	"terminal",
	"obsidian",
}

for _, name in ipairs(groups) do
	vim.list_extend(mappings, require("config.keymaps.leader." .. name))
end

return mappings
