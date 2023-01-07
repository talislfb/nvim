-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd.packeradd 'packer.nvim'
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Couldn't find packer plugin!")
	return
end

-- autocommand to runn packer when this file is saved
vim.cmd [[ 
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost packer.lua source <afile> | PackerSync
	augroup end
]]

packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	}
}

packer.startup(function(use)
	-- Utilities
	use 'wbthomason/packer.nvim'
	use 'windwp/nvim-autopairs'
	use 'akinsho/toggleterm.nvim'
	use 'nvim-tree/nvim-tree.lua'
	use 'ap/vim-css-color'

	-- Visual
	use 'akinsho/bufferline.nvim'
	use { 
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	} -- Statusline

	-- Git
	use 'lewis6991/gitsigns.nvim'
	use 'tpope/vim-fugitive'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- colorscheme
	use { 'catppuccin/nvim', as = 'catppuccin' }


	use { -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		run = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	}

	use { -- Additional text objects via treesitter
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
	}
	-- be able to see treesitter parsing info
	use 'nvim-treesitter/playground'

	-- file change history, like git branches
	use 'mbbill/undotree'

	-- add files bookmarks and quick switch keymaps
	use 'theprimeagen/harpoon'

	use { -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			'j-hui/fidget.nvim',

			-- Additional lua configuration, makes nvim stuff amazing
			'folke/neodev.nvim',
			'jose-elias-alvarez/null-ls.nvim'
		},
	}

	use { -- Autocompletion
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			-- snippets
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets'
		},
	}

	-- the first run will install packer and our plugins
	if packer_bootstrap then
		require("packer").sync()
		return
	end
end)
