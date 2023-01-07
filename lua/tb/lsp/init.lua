local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "tb.lsp.mason"
require("tb.lsp.handlers").setup()
