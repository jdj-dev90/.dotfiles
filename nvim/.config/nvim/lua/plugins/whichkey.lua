return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
	"nvim-lua/plenary.nvim"
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
	mode = "n",    -- NORMAL mode
	prefix = "<leader>",
	buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}


local mappings = {
	--[[ ["b"] = { ]]
	--[[ 	"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown())<cr>", ]]
	--[[ 	"Buffers", ]]
	--[[ }, ]]
	["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
	--[[ ["e"] = { "<cmd>Explore<cr>", "Explorer" }, ]]
	["e"] = { "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["cc"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

	d = {
		name = "DAP",
		ui = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		ct = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		tb = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },

		sv = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		si = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		so = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },

		sc = { "<cmd>lua require'dap.ui.variables'.scopes()<cr>", "Variable Scopes" },
		hh = { "<cmd>lua require'dap.ui.variables'.hover()<cr>", "Variable Hover" },
		hv = { "<cmd>lua require'dap.ui.variables'.visual_hover()<cr>", "Variable Visual Hover" },

		uh = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Widgets Hover" },
		uf = { "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", "Widgets Float" },


		sbr = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Conditional Breakpoint" },
		sbm = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Message Breakpoint" },


		ro = { "<cmd>lua require'dap'.repl.open()<CR>", "REPL Open" },
		rl = { "<cmd>lua require'dap'.repl.run_last()<CR>", "REPL Run Last" },
	},


	g = {
		name = "Git",
		s = { "<cmd>Git<CR>", "Fugitive" },
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		--[[ s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" }, ]]
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		w = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		u = { "<cmd>Telescope grep_string<cr>", "Search Text Under Cursor" },
		f = { "<cmd>Telescope find_files<cr>", "Find Files" },
	},
	t = {
		name = "Terminal",
		n = { "<cmd>lua _LAZYNPM_TOGGLE()<cr>", "NPM" },
		d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Docker" },
		o = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}


which_key.register(mappings, opts)

  end,
  opts = {
	plugins = {
		marks = true,    -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true,   -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true,   -- default bindings on <c-w>
			nav = true,       -- misc bindings to work with windows
			z = true,         -- bindings for folds, spelling and others prefixed with z
			-- g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+",    -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded",     -- none, single, double, shadow
		position = "bottom",    -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },                                            -- min and max height of the columns
		width = { min = 20, max = 50 },                                            -- min and max width of the columns
		spacing = 3,                                                               -- spacing between columns
		align = "left",                                                            -- align columns left, center or right
	},
	ignore_missing = true,                                                       -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                            -- show help message on the command line when the popup is visible
	triggers = "auto",                                                           -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}





