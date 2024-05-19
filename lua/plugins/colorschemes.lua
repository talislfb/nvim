return { -- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "moon",
		},
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			--vim.cmd.colorscheme("catppuccin")
		end,
	},
}
