-- Bind options
local opts = { noremap = true, silent = false }

-- Leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", opts, { desc = "Exit insert mode with jk" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)

-- vim.keymap.set("n", "<leader>p", ":Lexplore<cr>") -- when using netrw

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
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- window splits management
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts, { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sw", "<C-w>s", opts, { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", opts, { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", opts, { desc = "Close current split" })

-- resize splits
vim.keymap.set("n", "<leader>sl", ":resize +2<CR>", opts, { desc = "Increase horizontal split size" })
vim.keymap.set("n", "<leader>sh", ":resize -2<CR>", opts, { desc = "Decrease horizontal split size" })
vim.keymap.set("n", "<leader>sj", ":vertical resize -2<CR>", opts, { desc = "Decrease vertical split size" })
vim.keymap.set("n", "<leader>sk", ":vertical resize +2<CR>", opts, { desc = "Increase vertical split size" })

-- tabs management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", opts, { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", opts, { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", opts, { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", opts, { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabnew %<CR>", opts, { desc = "Open current buffer in new tab" })

-- navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

vim.keymap.set("n", "==", function()
	vim.lsp.buf.format()
end)

-- visual mode
-- move lines and auto indent
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

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
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostics [E]rror message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics [Q]uickfix list" })

-- quick fix navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Quick Fix: Next issue" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Quick Fix: Prev issue" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear higlights" })

-- paste over highlighted word, without losing buffer
vim.keymap.set("x", "p", '"_dP')
