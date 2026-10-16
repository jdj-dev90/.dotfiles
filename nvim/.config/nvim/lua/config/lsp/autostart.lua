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
	local function start(root_dir)
		local id = vim.lsp.start(vim.tbl_extend("force", cfg, { root_dir = root_dir }), { bufnr = bufnr })
		if id then
			vim.lsp.buf_attach_client(bufnr, id)
		end
	end
	-- vim.lsp.start only accepts a string root_dir; resolve function/root_markers
	-- forms the same way vim.lsp.enable does so its client gets reused.
	if type(cfg.root_dir) == "function" then
		cfg.root_dir(bufnr, start)
	elseif not cfg.root_dir and cfg.root_markers then
		start(vim.fs.root(bufnr, cfg.root_markers))
	else
		start(cfg.root_dir)
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

-- GDScript has no standalone LSP binary: the language server lives inside
-- the Godot editor and is reached over TCP (nvim-lspconfig's shipped
-- default connects to 127.0.0.1:6005), so it isn't Mason-managed like the
-- servers above. The Godot editor must be open with the project for this
-- to connect; if it isn't, vim.lsp.start fails quietly per-buffer.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gdscript" },
	callback = function(args)
		start_if_needed("gdscript", args.buf)
	end,
})
