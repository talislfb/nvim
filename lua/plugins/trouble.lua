return {
	"folke/trouble.nvim",
	dependecies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	keys = {
		-- TODO: test
		{ "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/Close trouble list" },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open Trouble workspace diagnostics" },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open Trouble document diagnostics" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open Trouble quick fix list" },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open Trouble location list" },
		{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
	}
}
