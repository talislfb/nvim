return {
	"echasnovski/mini.nvim",
	config = function()
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()
		require("mini.tabline").setup()
		require("mini.starter").setup()

		-- require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })

		require("mini.files").setup()
		vim.keymap.set(
			"n",
			"<leader>p",
			require("mini.files").open,
			{ noremap = true, silent = true },
			{ desc = "Open mini-files" }
		)
	end,
}
