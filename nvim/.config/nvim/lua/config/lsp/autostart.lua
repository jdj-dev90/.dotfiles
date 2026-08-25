local function start_if_needed(name, bufnr)
	local cfg = vim.lsp.config[name]
	if not cfg then
		return
	end
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if client.name == name then
			return
		end
	end
	local id = vim.lsp.start(cfg, { bufnr = bufnr })
	if id then
		vim.lsp.buf_attach_client(bufnr, id)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	callback = function(args)
		vim.defer_fn(function()
			start_if_needed("yamlls", args.buf)
		end, 150)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "gomod", "gowork", "gotmpl" },
	callback = function(args)
		start_if_needed("gopls", args.buf)
	end,
})
