-- Bind options
local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", opts)
-- disabled netrw (default file browser)
-- vim.keymap.set("n", "<leader>p", ':30Lexplore<cr>')
vim.keymap.set("n", "U", "<C-r>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- normal mode remaps
-- better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", ";q", ":q<CR>", opts)

-- resize windows
vim.keymap.set("n", "<A-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<A-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "==", function()
	vim.lsp.buf.format()
end)

-- visual mode
-- move lines and auto indent
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- window commands
-- splits
vim.keymap.set("n", "<leader>ws", ":vsplit<CR>", opts)
vim.keymap.set("n", "<leader>wh", ":hsplit<CR>", opts)

-- append lines without changing cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- half page jumping and keep cursor on the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- quick fix navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Quick Fix: Next issue" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Quick Fix: Prev issue" })

-- paste over highlighted word, without losing buffer
vim.keymap.set("x", "p", '"_dP')
