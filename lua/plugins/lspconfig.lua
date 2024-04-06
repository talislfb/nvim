-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
local function highlight_symbol(event)
	local id = vim.tbl_get(event, "data", "client_id")
	local client = id and vim.lsp.get_client_by_id(id)
	if client == nil or not client.supports_method("textDocument/documentHighlight") then
		return
	end

	local group = vim.api.nvim_create_augroup("highlight_symbol", { clear = false })

	vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.clear_references,
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr
			local lsp = vim.lsp.buf
			local bind = vim.keymap.set

			bind("n", "K", lsp.hover, opts)
			bind("n", "gd", lsp.definition, opts)
			bind("n", "gD", lsp.declaration, opts)
			bind("n", "gi", lsp.implementation, opts)
			bind("n", "go", lsp.type_definition, opts)
			bind("n", "gr", lsp.references, opts)
			bind("n", "gs", lsp.signature_help, opts)
			bind("n", "<F2>", lsp.rename, opts)
			bind("n", "<leader>ca", lsp.code_action, opts)

			bind("n", "gl", vim.diagnostic.open_float, opts)
			bind("n", "[d", vim.diagnostic.goto_prev, opts)
			bind("n", "]d", vim.diagnostic.goto_next, opts)

			local telescope = require("telescope")
			bind("n", "<leader>fd", telescope.lsp_document_symbols, opts)
			bind("n", "<leader>fq", telescope.lsp_workspace_symbols, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "Setup highlight symbol",
			callback = highlight_symbol,
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig['rust_analyzer'].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = {'rust'},
			settings = {
				['rust_analyzer'] = {
					cargo = {
						allFeatures = true,
					}
				}
			}
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
							[vim.fn.expand "${3rd}/love2d/library"] = true,
						},
					},
				},
			},
		})
	end,
}
