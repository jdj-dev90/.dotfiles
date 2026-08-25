local function get_log_path()
	if vim.lsp and vim.lsp.log and vim.lsp.log.get_filename then
		return vim.lsp.log.get_filename()
	end
	if vim.lsp and vim.lsp.get_log_path then
		return vim.lsp.get_log_path()
	end
	return nil
end

local function print_clients(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #clients == 0 then
		vim.api.nvim_out_write("Clients: none\n")
		return
	end
	for _, client in ipairs(clients) do
		local root = client.config and client.config.root_dir or "?"
		local cmd = client.config and client.config.cmd or {}
		local cmd_str = "?"
		if type(cmd) == "table" then
			cmd_str = table.concat(cmd, " ")
		elseif type(cmd) == "string" then
			cmd_str = cmd
		elseif type(cmd) == "function" then
			cmd_str = "<function>"
		end
		vim.api.nvim_out_write(string.format("- %s (id=%d)\n", client.name, client.id))
		vim.api.nvim_out_write(string.format("  root: %s\n", root))
		vim.api.nvim_out_write(string.format("  cmd: %s\n", cmd_str))
	end
end

local function print_log_tail(lines)
	if type(lines) ~= "table" or #lines == 0 then
		return
	end
	local start = math.max(1, #lines - 20)
	vim.api.nvim_out_write("Log (tail)\n")
	for i = start, #lines do
		vim.api.nvim_out_write("  " .. lines[i] .. "\n")
	end
end

local function collect_debug_info(bufnr)
	local clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		local root = client.config and client.config.root_dir or nil
		local cmd = client.config and client.config.cmd or {}
		table.insert(clients, {
			name = client.name,
			id = client.id,
			root = root,
			cmd = cmd,
		})
	end

	local log_path = get_log_path()
	local log_tail = {}
	if log_path then
		local ok, lines = pcall(vim.fn.readfile, log_path)
		if ok and type(lines) == "table" and #lines > 0 then
			local start = math.max(1, #lines - 20)
			for i = start, #lines do
				table.insert(log_tail, lines[i])
			end
		end
	end

	return {
		bufnr = bufnr,
		clients = clients,
		log_path = log_path,
		log_tail = log_tail,
	}
end

vim.api.nvim_create_user_command("LspDebugInfo", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local info = collect_debug_info(bufnr)
	vim.api.nvim_out_write(string.format("Buffer: %d\n", info.bufnr))
	vim.api.nvim_out_write("Clients\n")
	print_clients(bufnr)
	if info.log_path then
		vim.api.nvim_out_write(string.format("Log: %s\n", info.log_path))
		print_log_tail(info.log_tail)
	end

	local json = vim.fn.json_encode(info)
	local path = string.format("/tmp/nvim-lsp-debug-%d.json", bufnr)
	if vim.fn.executable("jq") == 1 then
		local pretty = vim.fn.system({ "jq", "." }, json)
		vim.fn.writefile(vim.split(pretty, "\n"), path)
		vim.api.nvim_out_write(string.format("Wrote %s (jq)\n", path))
		return
	end
	local inspect = vim.inspect(info)
	vim.fn.writefile(vim.split(inspect, "\n"), path)
	vim.api.nvim_out_write(string.format("Wrote %s (inspect)\n", path))
end, {})

if vim.fn.exists(":LspInfo") == 0 then
	vim.api.nvim_create_user_command("LspInfo", function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_out_write(string.format("LspInfo: buf=%d\n", bufnr))
		print_clients(bufnr)
	end, {})
end

local debug_enabled = vim.g.lsp_debug == true or vim.env.NVIM_LSP_DEBUG == "1"
if debug_enabled then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end
			local name = client.name or "unknown"
			vim.api.nvim_out_write(string.format("LspAttach: %s buf=%d\n", name, args.buf))
		end,
	})
end
