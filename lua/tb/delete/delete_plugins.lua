

packer.startup(function(use)
	-- Utilities
	use 'windwp/nvim-autopairs'
	use 'akinsho/toggleterm.nvim'

	-- add files bookmarks and quick switch keymaps
	use 'theprimeagen/harpoon'

	-- Visual
	use 'akinsho/bufferline.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lualine/lualine.nvim'

	-- Git
	use 'lewis6991/gitsigns.nvim'
	use 'tpope/vim-fugitive'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use 'nvim-telescope/telescope-file-browser.nvim'

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


	use 'simrat39/rust-tools.nvim'
	use 'cdelledonne/vim-cmake'

	-- debugging
	use {
		'mfussenegger/nvim-dap',
		requires = {
			'rcarriga/nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
			'nvim-telescope/telescope-dap.nvim',
			'mfussenegger/nvim-dap-python'
		}
	}

	use { -- Autocompletion
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			-- snippets
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets'
		},
	}

end)

vim.cmd[[let g:cmake_link_compile_commands = 1]]
