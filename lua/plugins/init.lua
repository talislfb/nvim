local Plugins = {
	"mbbill/undotree",

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim",             opts = {} },

	{ "nvim-tree/nvim-web-devicons",      lazy = true, opts = {} },
	{ "ap/vim-css-color",                 lazy = true },

	-- loading dap dependencies upfront
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text",  opts = {} },
	{ "nvim-telescope/telescope-dap.nvim" },

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim",            opts = {} },
}

return Plugins
