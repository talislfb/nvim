return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "think",
			diagnostics = false, -- | "nvim_lsp" | "coc",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			always_show_bufferline = false
		},
	},
}
