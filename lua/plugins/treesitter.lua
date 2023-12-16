local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.pin = true

Plugin.dependencies = {
	{ "nvim-treesitter/nvim-treesitter-textobjects", pin = true },
}

Plugin.opts = {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "html", "html.twig", "vimdoc" },
	},
	indent = { enable = true, disable = { "python", "yaml", "css" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autopairs = {
		enable = true,
	},
	ensure_installed = {
		"bash",
		"css",
		"c",
		"cpp",
		"html",
		"json",
		"jsdoc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"vim",
		"vimdoc",
		"python",
	},
}

function Plugin.config(_, opts)
	require("nvim-treesitter.configs").setup(opts)
end

return Plugin
