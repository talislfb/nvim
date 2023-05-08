return {
    'catppuccin/nvim', as = 'catppuccin',
    config = function()
        require("catppuccin").setup({
            flavour = 'mocha',
            transparent_background = true,
            integrations = {
                cmp = true,
                telescope = true,
                gitsigns = true,
                bufferline = true,
            }
        })

        --vim.cmd.colorscheme "catppuccin"
    end,
}