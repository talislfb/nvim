return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr
			local lsp = vim.lsp.buf
			local bind = vim.keymap.set
			local command = vim.api.nvim_buf_create_user_command

			command(0, "LspFormat", function()
				vim.lsp.buf.format({ async = true })
			end, {})

			-- set keybinds
			if vim.fn.mapcheck("==", "n") == "" then
				bind({ "n", "x" }, "==", "<cmd>LspFormat<cr>", opts)
			end

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

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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
						},
					},
				},
			},
		})
	end,
}
