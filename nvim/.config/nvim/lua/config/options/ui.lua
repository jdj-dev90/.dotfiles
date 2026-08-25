local options = {
	cursorline = false,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	guifont = "monospace:h17",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.o.winborder = "rounded"
