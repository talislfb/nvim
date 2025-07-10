return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "html", "html.twig", "vimdoc" },
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        indent = { enable = true, disable = { "python", "yaml", "css" } },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        autopairs = {
          enable = false,
        },
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "gdscript",
          "godot_resource",
          "gdshader",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "odin",
          "python",
          "rust",
          "toml",
          "usd",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- using <leader>ss for starting and increment selection for simplicity sake
            init_selection = "<Leader>ss",
            node_incremental = "<Leader>ss",
            scope_incremental = "<Leader>sc",
            node_decremental = "<Leader>sd",
          },
        },
        -- treesitter-textobjects
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- automatically jump forward to textobj, if not on top of the selected one
            keymaps = {
              -- uses capture groups defined in the textobjects.scm file (:TSEditQuery textobjects)
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "v", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
}
