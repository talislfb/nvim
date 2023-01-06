vim.opt.title = true
vim.opt.titlestring = "%<%F"

-- general configurations
vim.opt.nu = true -- show numbers
vim.opt.relativenumber = true
vim.opt.wrap = false -- no line wraps
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- tabs configurations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- tabs instead of spaces
vim.opt.smartindent = true
vim.opt.listchars = "tab:│ ,trail:·,nbsp:+"

-- backup and undo configurations
-- instead of UserProfile, use HOME for linux systems
vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- search configurations
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- faster update time
vim.opt.updatetime = 250

-- better complete experience
vim.o.completeopt = 'menuone,noselect'

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.opt.shortmess:append "c"
