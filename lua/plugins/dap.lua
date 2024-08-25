return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		{ "rcarriga/nvim-dap-ui" },
		{ "nvim-telescope/telescope-dap.nvim" },
		{ "theHamsta/nvim-dap-virtual-text",  opts = {} },
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>dS", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Breakpoint Condition" })
		vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
		vim.keymap.set("n", "<leader>dk", require("dapui").eval, { desc = "Evaluate expression" })
		vim.keymap.set("n", "<leader>dK", require("dap.ui.widgets").hover, { desc = "Hover (DapUI)" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.expand(
					"$HOME\\.vscode\\extensions\\vadimcn.vscode-lldb-1.10.0\\adapter\\codelldb.exe"
				),
				args = { "--port", "${port}" },
				detached = false,
			},
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
				stopOnEntry = false,
			},
		}

		dap.configurations.odin = dap.configurations.cpp
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		--[[dap.configurations.odin = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		local telescope = require("telescope")
		telescope.load_extension("dap")
	end,
}
