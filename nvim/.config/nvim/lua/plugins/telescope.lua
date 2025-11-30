return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		--[[ `open_with_trouble()` is deprecated ]]
		--[[ ```lua ]]
		--[[ -- Use this: ]]
		--[[ require("trouble.sources.telescope").open() ]]
		--[[]]
		--[[ -- Instead of: ]]
		--[[ require("trouble.providers.telescope").open_with_trouble() ]]

		local actions = require("telescope.actions")
		-- local trouble_providers = require("trouble.providers.telescope")
		-- local trouble_sources = require("trouble.sources.telescope")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-c>"] = actions.close,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						--[[ ["<C-t>"] = actions.select_tab, ]]
						-- ["<C-t>"] = trouble_sources.open,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						["<esc>"] = actions.close,
					},
					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						--[[ ["<C-t>"] = actions.select_tab, ]]
						-- ["<C-t>"] = trouble_sources.open,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,
						["?"] = actions.which_key,
					},
				},
				file_ignore_patterns = {
					".git",
					"node_modules",
					"assets",
					"dist",
					"package-lock.json",
					"JSON",
					".csv",
				},
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
			},
			preview = {
				filesize_limit = 25, -- MB
				treesitter = true,
				highlight_limit = 10, -- MB - increase from default 1MB
				filetype_hook = function(filepath, bufnr, opts)
					-- Ensure .tmpl files get gotmpl filetype in preview
					if filepath:match("%.tmpl$") then
						vim.bo[bufnr].filetype = "gotmpl"
					end
					return true -- Must return true to continue previewing
				end,
			},
			pickers = {
				find_files = {
					hidden = true,
					theme = "dropdown",
				},
				live_grep = {
					hidden = true,
					theme = "dropdown",
				},
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				fzf = {},
				-- please take a look at the readme of the extension you want to configure
			},
		})

		telescope.load_extension("fzf")

	end,
}
