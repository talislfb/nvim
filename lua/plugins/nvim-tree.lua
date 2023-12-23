return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function nv_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "O", "", { buffer = bufnr })
			vim.keymap.del("n", "O", { buffer = bufnr })
			vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
			vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
			vim.keymap.set("n", "D", "", { buffer = bufnr })
			vim.keymap.del("n", "D", { buffer = bufnr })
			vim.keymap.set("n", "E", "", { buffer = bufnr })
			vim.keymap.del("n", "E", { buffer = bufnr })

			vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "P", function()
				local node = api.tree.get_node_under_cursor()
				print(node.absolute_path)
			end, opts("Print Node Path"))

			vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
		end

		require("nvim-tree").setup({ on_attach = nv_on_attach })
		vim.keymap.set("n", "<leader>p", ":NvimTreeToggle<CR>")
	end,
}