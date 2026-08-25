return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptTitle = { fg = theme.ui.special, bold = true },
					TelescopeResultsTitle = { fg = theme.ui.special, bold = true },
					TelescopePreviewTitle = { fg = theme.ui.special, bold = true },
					TelescopeBorder = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
					TelescopeResultsBorder = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
					TelescopePreviewBorder = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
					TelescopePromptNormal = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
					TelescopePreviewNormal = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
					TelescopeSelection = { fg = theme.ui.fg, bg = theme.ui.bg_p2 },
					TelescopeMatching = { fg = theme.ui.special },
				}
			end,
		})

		local ok = pcall(vim.api.nvim_cmd, { cmd = "colorscheme", args = { "kanagawa" } }, {})
		if not ok then
			vim.api.nvim_cmd({ cmd = "colorscheme", args = { "default" } }, {})
			vim.o.background = "dark"
		end

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		local groups = {
			"TelescopeBorder",
			"TelescopeTitle",
			"SignColumn",
			"GitSignsAdd",
			"GitSignsChange",
			"GitSignsDelete",
			"CursorLine",
			"CursorLineNR",
		}
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#727169" })
	end,
}
