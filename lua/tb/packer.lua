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

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- colorscheme
	use { 'catppuccin/nvim', as = 'catppuccin' }

	use { 
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	} -- Statusline

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

	-- for git commands
	use 'tpope/vim-fugitive'

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
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets'
		},
	}

	use {
		'VonHeikemen/lsp-zero.nvim'
	}

	-- the first run will install packer and our plugins
	if packer_bootstrap then
		require("packer").sync()
		return
	end

end)

