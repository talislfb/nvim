local status_ok, dap = pcall(require, 'dap')
if not status_ok then
	vim.notify("Couldn't find dap plugin")
	return
end

vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<S-F11>', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>")

require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python.exe')
