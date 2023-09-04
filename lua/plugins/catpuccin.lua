local Plugin = {
	"catppuccin/nvim",
}

function Plugin.config()
	require("catppuccin").setup({
		flavour = "mocha",
		transparent_background = true,
		integrations = {
			cmp = true,
			telescope = true,
			gitsigns = true,
			bufferline = true,
		},
	})

	vim.cmd.colorscheme("catppuccin")
end

return Plugin
