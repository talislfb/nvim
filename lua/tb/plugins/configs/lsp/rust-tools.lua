local my_on_attach = require('tb.plugins.configs.lsp.handlers').on_attach
local my_capabilities = require('tb.plugins.configs.lsp.handlers').capabilities

local options = {
    server = {
        on_attach = my_on_attach,
        capabilities = my_capabilities,
    }
}

return options