local function set_lsp_log_level(level)
	if vim.lsp and vim.lsp.log and vim.lsp.log.set_level then
		vim.lsp.log.set_level(level)
		return
	end

	if vim.lsp and vim.lsp.set_log_level then
		vim.lsp.set_log_level(level)
	end
end

local level = vim.g.lsp_log_level or vim.env.NVIM_LSP_LOG_LEVEL
if level and level ~= "" then
	set_lsp_log_level(level)
end
