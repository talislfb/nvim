local Plugin = { "jose-elias-alvarez/null-ls.nvim" }

Plugin.dependencies = { { "nvim-lua/plenary.nvim" } }

function Plugin.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local config = {
		debug = false,
		sources = {
			formatting.prettier.with({
				extra_filetypes = { "toml" },
				extra_args = { "--no-semi", "single-quote", "jsx-single-quote" },
			}),
			formatting.stylua,
			formatting.clang_format,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	}

	null_ls.setup(config)
end

return Plugin
