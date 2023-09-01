local Plugin = { 'jose-elias-alvarez/null-ls.nvim' }

Plugin.dependencies = { { 'nvim-lua/plenary.nvim' } }

function Plugin.config()
	local null_ls = require('null-ls')

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local config = {
		debug = false,
		sources = {
			formatting.prettier.with {
				extra_filetypes = { 'toml' },
				extra_args = { '--no-semi', 'single-quote', 'jsx-single-quote' }
			},
			formatting.stylua,
			--diagnostics.flake8
		},
	}

	null_ls.setup(config)
end

return Plugin
