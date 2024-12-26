return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("telescope").setup({})
      local bind = vim.keymap.set

      -- Search pattern
      bind("n", "<leader>fa", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [A]ll (by Grep)" })

      -- Show key bindings list
      bind("n", "<leader>?", "<cmd>Telescope keymaps<cr>")
      bind("n", "<leader>fh", "<cmd>Telescope help_tags", { desc = "[F]ind [H]elp" })

      -- Find files by name
      bind("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "[F]ind [F]iles" })
      bind(
        "n",
        "<leader>fgf",
        "<cmd>lua require('telescope.builtin').git_files()<cr>",
        { desc = "[F]ind [G]it [F]iles" }
      )

      -- Search symbols in buffer
      bind("n", "<leader>fs", "<cmd>Telescope treesitter<cr>", { desc = "[F]ind [S]ymbols" })

      -- Search buffer lines
      bind("n", "<leader>f/", function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[f/] Fuzzily search in current buffer" })

      -- Search in active buffers list
      bind(
        "n",
        "<leader><space>",
        "<cmd>lua require('telescope.builtin').buffers()<cr>",
        { desc = "[ ] Find existing buffers" }
      )
      bind(
        "n",
        "<leader>fr",
        "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
        { desc = "[F]ind [r]ecently opened files" }
      )
      bind(
        "n",
        "<leader>fw",
        "<cmd>lua require('telescope.builtin').grep_string()<cr>",
        { desc = "[F]ind current [W]ord" }
      ) -- Find files neovim config files

      vim.keymap.set("n", "<leader>fn", function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[F]ind [N]eovim File" })

      -- Find files installed in the user's neovim's app folder
      vim.keymap.set("n", "<leader>fi", function()
        require("telescope.builtin").find_files({
          cwm = vim.fs.joinpath(vim.fn.stdpath("data", "lazy")),
        })
      end, { desc = "[F]ind [I]nstalled files" })
    end,
  },
}
