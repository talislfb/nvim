return {
    'jose-elias-alvarez/null-ls.nvim',
    opts = {
        require("null-ls").builtins.formatting.clang_format,
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.rustfmt,
        require("null-ls").builtins.diagnostics.flake8,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.diagnostics.clang_check
    }
}