require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'catppuccin',
		component_separators = '|',
		section_separators = '',
		disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
		always_divide_middle = true
	},
}
