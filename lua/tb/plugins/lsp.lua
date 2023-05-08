return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim', config = true,
                opts = {
                    ensure_installed = {
                        'rust_analyzer',
                        'taplo', -- toml files
                        'pyright',
                        'clangd',
                        'cmake',
                        'sumneko_lua'
                    },
                    automatic_installation = true
                }
            },
            'williamboman/mason-lspconfig.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'folke/neodev.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            {
                'ray-x/lsp_signature.nvim',
                opts = {
                    bind = true,
                    handler_opts = { border = 'rounded' }
                },
            },
        },
    },
    -- rust related lsp plugins
    {
        {
            'rust-lang/rust.vim',
            ft = 'rust',
            init = function()
                vim.g.rustfmt_autosave = 1
            end
        },
        {
            'simrat39/rust-tools.nvim',
            ft = 'rust',
            dependencies = 'neovim/nvim-lspconfig',
            opts = function()
                require 'tb.plugins.configs.lsp.rust-tools'
            end,
            config = function(_, opts)
                require('rust-tools').setup(opts)
                --require 'tb.plugins.configs.lsp.rust_analyzer'
            end,
        },
        {
            'saecki/crates.nvim',
            ft = {'rust', 'toml'},
            config = function(_, opts)
                local crates = require('crates')
                crates.setup(opts)
                --crates.show() -- uncomment this if not working
            end
            -- need to add crates to nvim-cmp sources
        }
    }
}
