return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "[F]ind [F]iles in current directory",
    },
    {
      "<leader>fa",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "[F]ind Grep (Find All) in current directory",
    },
    {
      "<leader>fn",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "[F]ind [N]neovim config",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").helptags()
      end,
      desc = "[F]ind [H]elp",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "[F]ind [K]eymaps",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "[F]ind [B]uiltin FZF",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "[F]ind [W]ord in current project",
    },
    {
      "<leader>fW",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "[F]ind [W]ORD in current project",
    },
    {
      "<leader>fd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "[F]ind [D]iagnostics",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").resume()
      end,
      desc = "[R]esumes the last thing being searched",
    },
    {
      "<leader>fo",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "[F]ind [O]ld files - all files open in neovim",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "[F]ind [B]buffers",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "[F]ind in [C]urrent buffer",
    },
    {
      "gd",
      function()
        require("fzf-lua").lsp_definitions()
      end,
      desc = "[G]o to [D]efinition",
    },
    {
      "gD",
      vim.lsp.buf.declaration,
      desc = "[G]o to [D]eclaration",
    },
    {
      "gI",
      function()
        require("fzf-lua").lsp_implementations()
      end,
      desc = "[G]o to [I]mplementation",
    },
    {
      "gr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "[G]o to [R]eferences",
    },
    {
      "grn",
      vim.lsp.buf.rename,
      desc = "[R]e[n]ame",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "[C]ode [A]ction",
    },
  },
}
