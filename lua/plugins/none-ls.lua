return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
			},
		})

		local command = vim.api.nvim_buf_create_user_command
		command(0, "LspFormat", function()
			vim.lsp.buf.format({ async = true })
		end, {})

		-- set keybinds
		vim.keymap.set("n", "<leader>==", "<cmd>LspFormat<cr>", {})
	end,
}
