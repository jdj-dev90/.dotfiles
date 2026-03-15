return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			return
		end

		local opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		which_key.add(require("config.keymaps").leader, opts)
		which_key.setup()
	end,
}
