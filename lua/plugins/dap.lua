local Plugins = {
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.keymap.set("n", "<leader>dr", dap.continue)
			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor)
			vim.keymap.set("n", "<leader>di", dap.step_into)
			vim.keymap.set("n", "<leader>ds", dap.step_over)
			vim.keymap.set("n", "<leader>do", dap.step_out)
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
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

			dap.adapters.codelldb = {
				type = "server",
				command = "C:\\Users\\talis\\.vscode\\extensions\\vadimcn.vscode-lldb-1.9.2\\adapter\\codelldb.exe",
				port = 13000,
				name = "codelldb",
			}

			local codelldb = {
				name = "Launch file",
				type = "codelldb",
				request = "launch", -- could also attach to a currently running process
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {},
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				runInTerminal = false,
			}

			dap.configurations.cpp = { codelldb }
			dap.configurations.c = dap.configurations.cpp
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			-- path to the script folder with debugpy
			local path = "C:\\Users\\talis\\scoop\\apps\\python\\3.11.4\\python"
			require("dap-python").setup(path)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		handlers = {},
	},
}

return Plugins
