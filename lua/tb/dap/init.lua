local status_ok, dap = pcall(require, 'dap')
if not status_ok then
	vim.notify("Couldn't find dap plugin")
	return
end

vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<F8>', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<S-F8>', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<F9>', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>")

require('nvim-dap-virtual-text').setup()
require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python.exe')

-- rust
require("dap").adapters.lldb = {
	type = "executable",
	command = "C:/Program Files/LLVM/bin/lldb-vscode.exe", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

require('dap').configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require('dapui').setup()
