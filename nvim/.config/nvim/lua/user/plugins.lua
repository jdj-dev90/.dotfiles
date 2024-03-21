local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim"   -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
	use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use "numToStr/Comment.nvim" -- Easily comment stuff
	use "akinsho/bufferline.nvim"
	use "moll/vim-bbye"
	use "nvim-lualine/lualine.nvim"
	use "yamatsum/nvim-cursorline"
	use "akinsho/toggleterm.nvim"
	use "lewis6991/impatient.nvim"
	use "lukas-reineke/indent-blankline.nvim"
	use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
	use "folke/which-key.nvim"
	use "ThePrimeagen/harpoon"

<<<<<<< HEAD
	-- mini
	use 'echasnovski/mini.files'
	use 'echasnovski/mini.cursorword'
=======
	--[[ mini ]]
	use 'echasnovski/mini.files' ---
	use 'echasnovski/mini.cursorword' ---
>>>>>>> cc0a6b3 (initial migration steps)

	use "b0o/schemastore.nvim"


	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})


	use { 'kevinhwang91/nvim-bqf' }
	use { 'junegunn/fzf', run = function()
		vim.fn['fzf#install']()
	end
	}

	-- LaTeX
	use 'lervag/vimtex'

	-- Markdown Preview
	use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
	})


	-- Colorschemes
	use "rebelot/kanagawa.nvim" ---

	-- Completion framework:
	use "hrsh7th/nvim-cmp" -- The completion plugin

	-- LSP completion source:
	use 'hrsh7th/cmp-nvim-lsp'

	-- Useful completion sources:
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-vsnip'
	use "hrsh7th/cmp-path"        -- path completions
	use "hrsh7th/cmp-buffer"      -- buffer completions
	use "hrsh7th/cmp-cmdline"     -- cmdline completions
	use 'hrsh7th/vim-vsnip'
	use "saadparwaiz1/cmp_luasnip" -- snippet completions

	-- snippets
	use "L3MON4D3/LuaSnip"            --snippet engine
	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- LSP
	use "neovim/nvim-lspconfig" -- enable LSP
	use { "williamboman/mason.nvim" }
	use { "williamboman/mason-lspconfig.nvim" }
	--[[ use { "jayp0521/mason-null-ls.nvim" } ]]
	use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
	use { "nvimtools/none-ls.nvim",   -- for formatters and linters
		requires = "nvimtools/none-ls-extras.nvim"
	}


	use "jose-elias-alvarez/typescript.nvim"
	use "simrat39/rust-tools.nvim"

	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				severity = vim.diagnostic.severity.ERROR,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

<<<<<<< HEAD
	-- Telescope
	use "nvim-telescope/telescope.nvim"
=======
	use {
		"zeioth/garbage-day.nvim",
		requires = "neovim/nvim-lspconfig",
	} ---REMOVE---

	-- Telescope
	use "nvim-telescope/telescope.nvim" ---
	use "nvim-telescope/telescope-media-files.nvim" ---REMOVE---
>>>>>>> cc0a6b3 (initial migration steps)

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function() require("nvim-treesitter.install").update { with_sync = true, prefer_git = true } end,
	} ---
	use 'nvim-treesitter/nvim-treesitter-context' ---
	use "JoosepAlviste/nvim-ts-context-commentstring" ---

	-- Git
	use "lewis6991/gitsigns.nvim"
	use "tpope/vim-fugitive"

	-- DB
	use 'tpope/vim-dadbod'
	use 'kristijanhusak/vim-dadbod-ui'
	use 'kristijanhusak/vim-dadbod-completion'


	-- DAP
	use 'mfussenegger/nvim-dap'
	use "jay-babu/mason-nvim-dap.nvim"
	use 'theHamsta/nvim-dap-virtual-text'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
	use { 'nvim-telescope/telescope-dap.nvim' }


	-- Tmux
	use "alexghergh/nvim-tmux-navigation"


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
