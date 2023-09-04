-- LSP support
local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.dependencies = {
	{
		'j-hui/fidget.nvim',
		tag = 'legacy',
		event = 'LspAttach'
	},
	{
		'williamboman/mason.nvim',
	},
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'folke/neodev.nvim',                opts = {} },
	{
		'ray-x/lsp_signature.nvim',
		opts = {
			bind = true,
			handler_opts = { border = 'rounded' }
		},
	},
}

function Plugin.config()
	user.diagnostics()
	user.handlers()

	-- add new config names here to be auto-started
	local auto_servers = {
		'nvim_lua',
		'pyright',
		'clangd'
	}

	require('fidget').setup({
		text = {
			spinner = 'moon'
		},
		window = {
			blend = 0
		},
		sources = {
			['null-ls'] = { ignore = true }
		}
	})

	require('mason').setup()

	require('mason-lspconfig').setup({
		ensure_installed = {
			"lua_ls",
			"rust_analyzer",
			"taplo", -- toml files
			"clangd",
			"cmake",
			"pyright",
			--'codelldb',
			--'clang-format'
		},
		automatic_installation = true
	})

	vim.api.nvim_create_user_command(
		'Lsp',
		function(input)
			if input.args == '' then
				return
			end

			require('plugins.lsp.servers').start(input.args, {})
		end,
		{ desc = 'Initialize a language server', nargs = '?' }
	)

	for _, server in pairs(auto_servers) do
		require('plugins.lsp.servers').start(server, {})
	end
end

function user.diagnostics()
	local sign = function(opts)
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = '',
		})
	end

	sign({ name = 'DiagnosticSignError', text = "" })
	sign({ name = 'DiagnosticSignWarn', text = "" })
	sign({ name = 'DiagnosticSignHint', text = "" })
	sign({ name = 'DiagnosticSignInfo', text = "" })

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = 'minimal',
			border = 'rounded',
			source = 'always',
			header = '',
			prefix = '',
			suffix = ''
		},
	})
end

function user.handlers()
	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = 'rounded' }
	)

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = 'rounded' }
	)

	local group = augroup('lsp_cmds', { clear = true })
	autocmd('LspAttach', { group = group, callback = user.lsp_attach })
end

function user.lsp_attach()
	if vim.b.lsp_attached then
		return
	end

	vim.b.lsp_attached = true

	local telescope = require('telescope.builtin')
	local lsp = vim.lsp.buf
	local bind = vim.keymap.set
	local command = vim.api.nvim_buf_create_user_command

	command(0, 'LspFormat', function()
		vim.lsp.buf.format({ async = true })
		end, {})

	local opts = { silent = true, buffer = true }

	if vim.fn.mapcheck('==', 'n') == '' then
		bind({ 'n', 'x' }, '==', '<cmd>LspFormat<cr>', opts)
	end

	bind('n', 'K', lsp.hover, opts)
	bind('n', 'gd', lsp.definition, opts)
	bind('n', 'gD', lsp.declaration, opts)
	bind('n', 'gi', lsp.implementation, opts)
	bind('n', 'go', lsp.type_definition, opts)
	bind('n', 'gr', lsp.references, opts)
	bind('n', 'gs', lsp.signature_help, opts)
	bind('n', '<F2>', lsp.rename, opts)
	bind('n', '<F4>', lsp.code_action, opts)
	--  bind('x', '<F4>', lsp.range_code_action, opts)

	bind('n', 'gl', vim.diagnostic.open_float, opts)
	bind('n', '[d', vim.diagnostic.goto_prev, opts)
	bind('n', ']d', vim.diagnostic.goto_next, opts)

	bind('n', '<leader>fd', telescope.lsp_document_symbols, opts)
	bind('n', '<leader>fq', telescope.lsp_workspace_symbols, opts)
end

return Plugin
