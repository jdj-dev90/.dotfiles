return {
	{ "<leader>d", group = "DAP", nowait = true, remap = false },
	{
		"<leader>dct",
		function()
			require("dap").continue()
		end,
		desc = "Continue",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dhh",
		function()
			require("dap.ui.variables").hover()
		end,
		desc = "Variable Hover",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dhv",
		function()
			require("dap.ui.variables").visual_hover()
		end,
		desc = "Variable Visual Hover",
		nowait = true,
		remap = false,
	},
	{
		"<leader>drl",
		function()
			require("dap").repl.run_last()
		end,
		desc = "REPL Run Last",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dro",
		function()
			require("dap").repl.open()
		end,
		desc = "REPL Open",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dsbm",
		function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end,
		desc = "Message Breakpoint",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dsbr",
		function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end,
		desc = "Conditional Breakpoint",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dsc",
		function()
			require("dap.ui.variables").scopes()
		end,
		desc = "Variable Scopes",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dsi",
		function()
			require("dap").step_into()
		end,
		desc = "Step Into",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dso",
		function()
			require("dap").step_out()
		end,
		desc = "Step Out",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dsv",
		function()
			require("dap").step_over()
		end,
		desc = "Step Over",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dtb",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
		nowait = true,
		remap = false,
	},
	{
		"<leader>duf",
		function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end,
		desc = "Widgets Float",
		nowait = true,
		remap = false,
	},
	{
		"<leader>duh",
		function()
			require("dap.ui.widgets").hover()
		end,
		desc = "Widgets Hover",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dui",
		function()
			require("dapui").toggle()
		end,
		desc = "Toggle UI",
		nowait = true,
		remap = false,
	},
}
