return {
  'mbbill/undotree',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  { 'nvim-tree/nvim-web-devicons', lazy = true, opts = {} },
  { 'ap/vim-css-color', lazy = true },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
},

{ -- Autocompletion
'hrsh7th/nvim-cmp',
dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },
    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
  end,
},

{ -- Add indentation guides even on blank lines
'lukas-reineke/indent-blankline.nvim',
-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
opts = {
  char = '┊',
  show_trailing_blankline_indent = false,
},
},

-- Fuzzy Finder (files, lsp, etc)
{ 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.
{
  'nvim-telescope/telescope-fzf-native.nvim',
  -- NOTE: If you are having trouble with this installation,
  --       refer to the README for telescope-fzf-native for more instructions.
  build = 'make',
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
},

{ -- Highlight, edit, and navigate code
'nvim-treesitter/nvim-treesitter',
dependencies = {
  'nvim-treesitter/nvim-treesitter-textobjects',
},
build = ":TSUpdate",
  },
}
