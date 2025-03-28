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
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}

		which_key.add({
			{
				"<leader>b",
				"<cmd>Telescope buffers<cr>",
				desc = "Buffers",
				nowait = true,
				remap = false,
			},
			{
				"<leader>cc",
				"<cmd>bdelete!<CR>",
				desc = "Close Buffer",
				nowait = true,
				remap = false,
			},
			{ "<leader>d", group = "DAP", nowait = true, remap = false },
			{
				"<leader>dct",
				"<cmd>lua require'dap'.continue()<cr>",
				desc = "Continue",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dhh",
				"<cmd>lua require'dap.ui.variables'.hover()<cr>",
				desc = "Variable Hover",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dhv",
				"<cmd>lua require'dap.ui.variables'.visual_hover()<cr>",
				desc = "Variable Visual Hover",
				nowait = true,
				remap = false,
			},
			{
				"<leader>drl",
				"<cmd>lua require'dap'.repl.run_last()<CR>",
				desc = "REPL Run Last",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dro",
				"<cmd>lua require'dap'.repl.open()<CR>",
				desc = "REPL Open",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dsbm",
				"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				desc = "Message Breakpoint",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dsbr",
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				desc = "Conditional Breakpoint",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dsc",
				"<cmd>lua require'dap.ui.variables'.scopes()<cr>",
				desc = "Variable Scopes",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dsi",
				"<cmd>lua require'dap'.step_into()<cr>",
				desc = "Step Into",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dso",
				"<cmd>lua require'dap'.step_out()<cr>",
				desc = "Step Out",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dsv",
				"<cmd>lua require'dap'.step_over()<cr>",
				desc = "Step Over",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dtb",
				"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
				desc = "Toggle Breakpoint",
				nowait = true,
				remap = false,
			},
			{
				"<leader>duf",
				"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
				desc = "Widgets Float",
				nowait = true,
				remap = false,
			},
			{
				"<leader>duh",
				"<cmd>lua require'dap.ui.widgets'.hover()<cr>",
				desc = "Widgets Hover",
				nowait = true,
				remap = false,
			},
			{
				"<leader>dui",
				"<cmd>lua require'dapui'.toggle()<cr>",
				desc = "Toggle UI",
				nowait = true,
				remap = false,
			},
			{
				"<leader>e",
				"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
				desc = "Explorer",
				nowait = true,
				remap = false,
			},
			{ "<leader>g", group = "Git", nowait = true, remap = false },
			{
				"<leader>gD",
				"<cmd>:DiffviewOpen main<cr>",
				desc = "Diffview Open main",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gL",
				"<cmd>:Neogit log<cr>",
				desc = "Log",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gP",
				"<cmd>:Neogit push<cr>",
				desc = "Push",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gR",
				"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
				desc = "Reset Buffer",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gb",
				"<cmd>Telescope git_branches<cr>",
				desc = "Checkout branch",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gc",
				"<cmd>Telescope git_commits<cr>",
				desc = "Checkout commit",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gdc",
				"<cmd>:DiffviewClose<cr>",
				desc = "Diffview Close",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gdo",
				"<cmd>:DiffviewOpen<cr>",
				desc = "Diffview Open",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gg",
				"<cmd>:Neogit<cr>",
				desc = "Neogit",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gj",
				"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
				desc = "Next Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gk",
				"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
				desc = "Prev Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gl",
				"<cmd>lua require 'gitsigns'.blame_line()<cr>",
				desc = "Blame",
				nowait = true,
				remap = false,
			},
			{
				"<leader>go",
				"<cmd>Telescope git_status<cr>",
				desc = "Open changed file",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gp",
				"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
				desc = "Preview Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gr",
				"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
				desc = "Reset Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gs",
				"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
				desc = "Stage Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gu",
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				desc = "Undo Stage Hunk",
				nowait = true,
				remap = false,
			},
			{ "<leader>l", group = "LSP", nowait = true, remap = false },
			{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
			{
				"<leader>lS",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "Workspace Symbols",
				nowait = true,
				remap = false,
			},
			{
				"<leader>la",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				desc = "Code Action",
				nowait = true,
				remap = false,
			},
			{
				"<leader>ld",
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				desc = "Document Diagnostics",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lf",
				"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
				desc = "Format",
				nowait = true,
				remap = false,
			},
			{
				"<leader>li",
				"<cmd>LspInfo<cr>",
				desc = "Info",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lj",
				"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
				desc = "Next Diagnostic",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lk",
				"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
				desc = "Prev Diagnostic",
				nowait = true,
				remap = false,
			},
			{
				"<leader>ll",
				"<cmd>lua vim.lsp.codelens.run()<cr>",
				desc = "CodeLens Action",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lq",
				"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
				desc = "Quickfix",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lr",
				"<cmd>lua vim.lsp.buf.rename()<cr>",
				desc = "Rename",
				nowait = true,
				remap = false,
			},
			{
				"<leader>ls",
				"<cmd>Telescope lsp_document_symbols<cr>",
				desc = "Document Symbols",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lw",
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				desc = "Workspace Diagnostics",
				nowait = true,
				remap = false,
			},
			{ "<leader>o", group = "Obsidian", nowait = true, remap = false },
			{
				"<leader>q",
				"<cmd>q!<CR>",
				desc = "Quit",
				nowait = true,
				remap = false,
			},
			{ "<leader>s", group = "Search", nowait = true, remap = false },
			{
				"<leader>sC",
				"<cmd>Telescope commands<cr>",
				desc = "Commands",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sM",
				"<cmd>Telescope man_pages<cr>",
				desc = "Man Pages",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sR",
				"<cmd>Telescope registers<cr>",
				desc = "Registers",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sb",
				"<cmd>Telescope git_branches<cr>",
				desc = "Checkout branch",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sc",
				"<cmd>Telescope colorscheme<cr>",
				desc = "Colorscheme",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sf",
				"<cmd>Telescope find_files<cr>",
				desc = "Find Files",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sh",
				"<cmd>Telescope help_tags<cr>",
				desc = "Find Help",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sk",
				"<cmd>Telescope keymaps<cr>",
				desc = "Keymaps",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sr",
				"<cmd>Telescope oldfiles<cr>",
				desc = "Open Recent File",
				nowait = true,
				remap = false,
			},
			{
				"<leader>su",
				"<cmd>Telescope grep_string<cr>",
				desc = "Search Text Under Cursor",
				nowait = true,
				remap = false,
			},
			{
				"<leader>sw",
				"<cmd>Telescope live_grep<cr>",
				desc = "Find Text",
				nowait = true,
				remap = false,
			},
			{ "<leader>t", group = "Terminal", nowait = true, remap = false },
			{
				"<leader>td",
				"<cmd>lua _LAZYDOCKER_TOGGLE()<cr>",
				desc = "Docker",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<cr>",
				desc = "Float",
				nowait = true,
				remap = false,
			},
			{
				"<leader>th",
				"<cmd>!tmux split-window -h -b<cr>",
				desc = "Split Left",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tj",
				"<cmd>tmux split-window -v<cr>",
				desc = "Split Down",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tk",
				"<cmd>tmux split-window -v -b<cr>",
				desc = "Split Up",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tl",
				"<cmd>tmux split-window -h<cr>",
				desc = "Split Right",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tn",
				"<cmd>lua _LAZYNPM_TOGGLE()<cr>",
				desc = "NPM",
				nowait = true,
				remap = false,
			},
			{
				"<leader>to",
				"<cmd>lua _NODE_TOGGLE()<cr>",
				desc = "Node",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tp",
				"<cmd>lua _PYTHON_TOGGLE()<cr>",
				desc = "Python",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tt",
				"<cmd>lua _HTOP_TOGGLE()<cr>",
				desc = "Htop",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tu",
				"<cmd>lua _NCDU_TOGGLE()<cr>",
				desc = "NCDU",
				nowait = true,
				remap = false,
			},
			{
				"<leader>w",
				"<cmd>w!<CR>",
				desc = "Save",
				nowait = true,
				remap = false,
			},
			{
				mode = { "n", "v" },
				{
					"<leader>od",
					"<cmd>!rm '%:p'<cr>:bd<cr>",
					desc = "Delete Note",
					nowait = true,
					remap = false,
				},
				{
					"<leader>of",
					'<cmd>Telescope find_files search_dirs={"$SECOND_BRAIN/notes"}<CR>',
					desc = "Search SB Files",
					nowait = true,
					remap = false,
				},
				{
					"<leader>ok",
					"<cmd>!mv '%:p' $SECOND_BRAIN/zettelkasten<cr>:bd<cr>",
					desc = "Accept Note",
					nowait = true,
					remap = false,
				},
				{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note", nowait = true, remap = false },
				{ "<leader>oo", "<cmd>cd $SECOND_BRAIN<CR>", desc = "Navigate To Vault", nowait = true, remap = false },
				{
					"<leader>os",
					'<cmd>Telescope live_grep search_dirs={"$SECOND_BRAIN/notes"}<CR>',
					desc = "Grep SB",
					nowait = true,
					remap = false,
				},
				{
					"<leader>otn",
					"<cmd>ObsidianTemplate note<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>",
					desc = "Note Template",
					nowait = true,
					remap = false,
				},
				{
					"<leader>ots",
					"<cmd>ObsidianTemplate uni-subject<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>",
					desc = "Uni-Subject Template",
					nowait = true,
					remap = false,
				},
				{
					"<leader>otu",
					"<cmd>ObsidianTemplate uni-note<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>",
					desc = "Uni-Note Template",
					nowait = true,
					remap = false,
				},
				{
					"<leader>ox",
					"<cmd>g/^# /s/-/ /g | g/^# /s/_/ - /g<cr>",
					desc = "Fix Title",
					nowait = true,
					remap = false,
				},
			},
		})

		which_key.setup()
	end,
}
