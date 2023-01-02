
require('catppuccin').setup({
	flavour = 'mocha',
	transparent_background = true,
	integrations = {
		cmp = true,
		telescope = true,
		gitsigns = true
	}
})

vim.cmd.colorscheme 'catppuccin'
