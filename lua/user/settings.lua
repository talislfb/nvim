vim.g.have_nerd_font = true

-- Ignore the case when the search pattern is all lowercase
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- disable the netrw plugin in case there's another one
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0

-- hide netrw banner (Use I to show it temporarely)
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 30
-- vim.g.netrw_liststyle = 3
-- keep current directory and browsing directory synched
-- vim.g.netrw_keepdir = 0

-- search configurations
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- better complete experience
vim.opt.completeopt = 'noselect,menu,menuone,noinsert,popup'

-- allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start"

-- general configurations
vim.opt.nu = true    -- show numbers
vim.opt.relativenumber = true
vim.opt.wrap = false -- no line wraps
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.mouse = "a"
vim.opt.list = true
-- Don't show mode, since it's already in status line
vim.opt.showmode = false

-- Use the pretty colors
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark

-- When opening a window put it right or below the current one
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = 'rounded'

-- Enable cursorline
vim.opt.cursorline = true

-- Always display signcolumn (for diagnostic related stuff)
vim.opt.signcolumn = "yes"

-- Keep lines below cursor when scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- Set grep default grep command with ripgrep
vim.opt.grepprg = "rg --vimgrep --follow"
vim.opt.errorformat:append("%f:%l:%c%p%m")

-- faster update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.shortmess:append("c")
vim.opt.wildignore:append("**/node_modules/*")
vim.opt.wildignore:append("**/.git/*")
