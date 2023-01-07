local cat_status_ok, catppuccin = pcall(require, 'catppuccin')
if not cat_status_ok then
	vim.notify("Couldn't find catppuccin plugin!")
	return
end

catppuccin.setup({
	flavour = 'mocha',
	transparent_background = true,
	integrations = {
		cmp = true,
		telescope = true,
		gitsigns = true,
		bufferline = true,
	}
})

local colorscheme = 'catppuccin-mocha'

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
	vim.notify('colorscheme ' .. colorscheme .. ' not found!')
	return
end

