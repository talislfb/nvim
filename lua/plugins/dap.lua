local Plugins = {
	{ 'mfussenegger/nvim-dap' },
	{
		'rcarriga/nvim-dap-ui',
		dependencies = { 'mfussenegger/nvim-dap' },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set('n', '<F5>', dap.continue)
			vim.keymap.set('n', '<F7>', dap.step_into)
			vim.keymap.set('n', '<F8>', dap.step_over)
			vim.keymap.set('n', '<S-F7>', dap.step_out)
			vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
			vim.keymap.set('n', '<leader>dB', function()
				dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end)

			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		'mfussenegger/nvim-dap-python',
		ft = 'python',
		dependencies = {
			'mfussenegger/nvim-dap',
			'rcarriga/nvim-dap-ui'
		},
		config = function(_, opts)
			-- path to the script folder with debugpy
			local path = 'C:\\Users\\talis\\scoop\\apps\\python\\3.11.4\\python'
			require('dap-python').setup(path)
		end
	},
}

return Plugins

