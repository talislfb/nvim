local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

local my_on_attach = require('tb.plugins.configs.lsp.handlers').on_attach
local my_capabilities = require('tb.plugins.configs.lsp.handlers').capabilities

lspconfig.rust_analyzer.setup({
    on_attach = my_on_attach,
    capabilities = my_capabilities,
    filetypes = {'rust'},
    root_dir = util.root_pattern('Cargo.toml'),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            }
        }
    }
})