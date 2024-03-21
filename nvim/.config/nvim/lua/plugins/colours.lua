return {
	"rebelot/kanagawa.nvim",
	config = function()
		vim.cmd [[
			try
				colorscheme kanagawa
			catch /^Vim\%((\a\+)\)\=:E185/
				colorscheme default
				set background=dark
			endtry
		]]

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.cmd 'highlight TelescopeBorder guibg=none'
		vim.cmd 'highlight TelescopeTitle guibg=none'
		vim.cmd 'highlight SignColumn guibg=none'
		vim.cmd 'highlight GitSignsAdd guibg=none'
		vim.cmd 'highlight GitSignsChange guibg=none'
		vim.cmd 'highlight GitSignsDelete guibg=none'

		vim.cmd 'highlight LineNr guibg=none'
		vim.cmd 'highlight CursorLine guibg=none'
		vim.cmd 'highlight CursorLineNR guibg=none'
	end
}
