local Plugin = {'jose-elias-alvarez/null-ls.nvim'}

Plugin.dependencies = {{'nvim-lua/plenary.nvim'}}

function Plugin.config()
    local null_ls = require('null-ls')

    local diagnostics = null_ls.builtins.diagnostics

    local config = {
        on_attach = function(client, bufnr)
            local bufcmd = vim.api.nvim_buf_create_user_command
            local format_cmd = function(input)
                vim.lsp.buf.format({
                    id = client.id,
                    timeout_ms = 5000,
                    async = input.bang,
                })
            end

            bufcmd(bufnr, 'NullFormat', format_cmd, {
                bang = true,
                range = true,
                desc = 'Format using null-ls'
            })

            vim.keymap.set({'n', 'x'}, '<leader>kd', '<cmd>NullFormat!<cr>', {
                buffer = bufnr
            })

			if client.supports_method('textDocument/formatting') then
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr
				})
				vim.api.nvim_create_autocmd({
					group = augroup,
					buffer = bufnr,
					callback = function ()
						vim.lsp.format({ bufnr = bufnr })
					end
				})
			end

        end,
        sources = {
            diagnostics.mypy,
            diagnostics.ruff
        }
    }

    null_ls.setup(config)
end

return Plugin
