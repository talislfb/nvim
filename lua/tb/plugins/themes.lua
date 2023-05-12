return {
    {
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

            -- vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
        -- uncomment next line to enable onedark theme
        vim.cmd.colorscheme 'onedark'
        end,
    }
}
