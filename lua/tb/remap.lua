vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.g.mapleader = " "
vim.g.maplocalleader = ' '

local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("i", "jk", "<ESC>", opts)
keymap('t', 'jk', '<C-\\><C-n>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- normal mode remaps
-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- append lines without changing cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- half page jumping and keep cursor on the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over highlighted word, without losing buffer
vim.keymap.set("x", "p", '"_dP')

-- copy into the system buffer
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- move this to lsp, maybe
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

-- quick fix navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- visual mode
-- move lines and auto indent
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- keeps highlighted session while indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- cancel search highlighted with ESC
keymap('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', opts)