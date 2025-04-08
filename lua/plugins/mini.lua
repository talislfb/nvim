return {
  "echasnovski/mini.nvim",
  config = function()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
    require("mini.tabline").setup()
    require("mini.starter").setup()
    require("mini.icons").setup()

    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = vim.g.have_nerd_font })
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    require("mini.files").setup({
      windows = {
        preview = true,
        width_preview = 50,
      },
    })
    vim.keymap.set("n", "<leader>p", require("mini.files").open, {
      desc = "Open mini-files",
      noremap = true,
      silent = true,
    })
  end,
}
