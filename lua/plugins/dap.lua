return {
	"mfussenegger/nvim-dap",
	dependecies = {
		"williamboman/mason.nvim"
	},
	keys = {
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dr", function() require("dap").continue() end, desc = "Continue" },
		{ "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
		{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
		{ "<leader>du", function() require("dap").up() end, desc = "Up" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
		{ "<leader>dS", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>ds", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

		{ "<leader>dk", function() require("dapui").eval() end, desc = "Evaluate expression under cursor (DapUi)" },
	},
	config = function()
		local dap = require("dap")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.expand("$HOME\\.vscode\\extensions\\vadimcn.vscode-lldb-1.10.0\\adapter\\codelldb.exe"),
				args = { "--port", "${port}" },
				detached = false
			}
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false
			}
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		local dapui = require("dapui")
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.expand("$HOME\\.vscode\\extensions\\vadimcn.vscode-lldb-1.10.0\\adapter\\codelldb.exe"),
				args = { "--port", "${port}" },
				detached = false
			}
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false
			}
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		local telescope = require("telescope")
		telescope.load_extension("dap")
	end,
}
