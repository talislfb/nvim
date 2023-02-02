require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = '|',
		section_separators = '',
		disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
		always_divide_middle = true
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		--lualine_c = {'buffers'},
		lualine_x = {'tabs'},
		lualine_y = {'progress'},
		lualine_z = {
			{ 'diagnostics',
				sources = {'nvim_diagnostic', 'nvim_lsp'},
				sections = {'error', 'warn', 'info', 'hint'},
				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = 'DiagnosticError', -- Changes diagnostics' error color.
					warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
					info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
					hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
				},
				symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
				colored = true,           -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false,   -- Show diagnostics even if there are none.
			}
		}
	}
}
