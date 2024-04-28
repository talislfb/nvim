return {
	"echasnovski/mini.nvim",
	config = function()

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		statusline.section_location = function()
			return "%2l:%-2v"
		end

		require("mini.files").setup()
		vim.keymap.set("n", "<leader>p", require("mini.files").open, {noremap = true, silent = true}, {desc = "Open mini-files" })
	end,
}
