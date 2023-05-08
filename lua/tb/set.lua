vim.opt.title = true
vim.opt.titlestring = "%<%F"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- general configurations
vim.opt.nu = true -- show numbers
vim.opt.relativenumber = true
vim.opt.wrap = false -- no line wraps
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.mouse = 'a'

-- tabs configurations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- tabs instead of spaces
vim.opt.smartindent = true
vim.opt.listchars = "tab:│ ,trail:·,nbsp:+"
vim.opt.breakindent = true

-- backup and undo configurations
-- instead of UserProfile, use HOME for linux systems
vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- search configurations
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.clipboard = 'unnamedplus'

vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- faster update time
vim.opt.updatetime = 250

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true
vim.opt.wildignore:append '**/node_modules/*'
vim.opt.wildignore:append '**/.git/*'

-- better complete experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.opt.shortmess:append "c"
