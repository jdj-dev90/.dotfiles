local function open_exec_buffer()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false

	pcall(vim.api.nvim_open_win, buf, true, { split = "right" })

	return buf
end

vim.api.nvim_create_user_command("Exec", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file == nil or file == "" then
		vim.notify("Exec: no file to run", vim.log.levels.WARN)
		return
	end

	local output = vim.fn.systemlist({ "sh", file })
	local buf = open_exec_buffer()
	vim.bo[buf].filetype = "sh"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
end, {})

vim.api.nvim_create_user_command("ReloadConfig", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^config") then
			package.loaded[name] = nil
		end
	end
	local ok, err = pcall(dofile, vim.env.MYVIMRC)
	if ok then
		vim.notify("Config reloaded", vim.log.levels.INFO)
	else
		vim.notify("Reload failed: " .. tostring(err), vim.log.levels.ERROR)
	end
end, {})
