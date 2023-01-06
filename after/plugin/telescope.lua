local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end

local actions = require('telescope.actions')

telescope.setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,

				['<C-n>'] = actions.cycle_history_next,
				['<C-p>'] = actions.cycle_history_prev,
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,

				['<C-c>'] = actions.close,
			},
			n = {
				['j'] = actions.move_selection_next,
				['k'] = actions.move_selection_previous
			}
		},
	},
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fgf', builtin.git_files, { desc = '[F]ind [G]it Files' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
