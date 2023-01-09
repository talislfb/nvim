local servers = {
	"sumneko_lua",
	"pyright",
	"jsonls",
	"eslint",
	"rust_analyzer",
	"taplo", -- toml files
	"clangd",
	"cmake",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true
})

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
	vim.notify("Couldn't find lspconfig plugin!")
	return
end

local opts = {
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
		}
	}
}

for _, server in pairs(servers) do
	opts = {
		on_attach = require('tb.lsp.handlers').on_attach,
		capabilities = require('tb.lsp.handlers').capabilities,
	}

	server = vim.split(server, '@')[1]

	local require_ok, conf_opts = pcall(require, 'tb.lsp.settings.' .. server)
	if require_ok then
		opts = vim.tbl_deep_extend('force', conf_opts, opts)
	end

	if server == 'rust_analyzer' then
		require('rust-tools').setup {
			tools = {
				on_initialized = function()
					vim.cmd [[
						autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
					]]
				end,
			},
			server = {
				on_attach = require("tb.lsp.handlers").on_attach,
				capabilities = require("tb.lsp.handlers").capabilities,
				settings = {
					["rust-analyzer"] = {
						lens = {
							enable = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				}
			}
		}

		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
