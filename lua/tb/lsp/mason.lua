local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
	vim.notify("Couldn't find required mason plugin!")
	return
end

local install_root_dir = vim.fn.stdpath "data" .. "/mason"
local extension_path = install_root_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

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

mason.setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true
})

local lsp_signature_status_ok, lspsignature = pcall(require, 'lsp_signature')
if lsp_signature_status_ok then
	lspsignature.setup {
		bind = true,
		handler_opts = {
			border = 'rounded'
		}
	}
end

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
		flags = {
			debounce_text_changes = 150
		}
	}

	server = vim.split(server, '@')[1]

	local require_ok, conf_opts = pcall(require, 'tb.lsp.settings.' .. server)
	if require_ok then
		opts = vim.tbl_deep_extend('force', conf_opts, opts)
	end

	if server == 'rust_analyzer' then
		require('rust-tools').setup {
			tools = {
				hover_actions = { border = "solid" },
				on_initialized = function()
					vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
						pattern = { "*.rs" },
						callback = function()
							vim.lsp.codelens.refresh()
						end,
					})
				end,
			},
			server = opts,
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		}
	end

	lspconfig[server].setup(opts)
end
