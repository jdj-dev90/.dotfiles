local options = {
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	textwidth = 80,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.textwidth = 120
	end,
})

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
