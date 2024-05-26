return { -- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "night",
		},
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("kanagawa-dragon")
		end
	},
}
