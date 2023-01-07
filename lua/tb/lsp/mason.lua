local servers = {
	"sumneko_lua",
	"pyright",
	"jsonls",
	"eslint",
	"rust_analyzer",
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

	lspconfig[server].setup(opts)
end
