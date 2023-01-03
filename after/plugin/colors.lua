
require('catppuccin').setup({
	flavour = 'mocha',
	transparent_background = true,
	integrations = {
		cmp = true,
		telescope = true,
		gitsigns = true
	}
})

local colorscheme = 'catppuccin'

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
	vim.notify('colorscheme ' .. colorscheme .. ' not found!')
	return
end

