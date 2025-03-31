vim.lsp.enable({ "clangd", "luals", "ols", "rust_analyzer", "pyright" })

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})

-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
local function highlight_symbol(event)
  local id = vim.tbl_get(event, "data", "client_id")
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil or not client:supports_method("textDocument/documentHighlight", event.buf) then
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

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Setup highlight symbol",
  callback = highlight_symbol,
})
