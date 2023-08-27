local Plugin = { 'nvim-treesitter/nvim-treesitter' }
Plugin.pin = true

Plugin.dependencies = {
	{ 'nvim-treesitter/nvim-treesitter-textobjects', pin = true },
	{ 'JoosepAlviste/nvim-ts-context-commentstring' },
}

Plugin.opts = {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { 'html', 'html.twig', 'vimdoc' },
	},
	indent = { enable = true, disable = { 'yaml', 'css' } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			node_decremental = '<a-space>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			}
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	ensure_installed = {
		'html',
		'css',
		'json',
		'lua',
		'c',
		'cpp',
		'vim',
		'vimdoc',
		'python'
	},
}

function Plugin.build()
	pcall(vim.cmd, 'TSUpdate')
end

function Plugin.config(_, opts)
	require('nvim-treesitter.configs').setup(opts)
end

return Plugin

