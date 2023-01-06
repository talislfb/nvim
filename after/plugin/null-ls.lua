local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
	vim.notify("Couldn't find null-ls plugin")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
	formatting.clang_format,
	formatting.stylua,
	formatting.rustfmt,
	diagnostics.flake8,
	diagnostics.eslint,
	diagnostics.clang_check
}
