return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    'nvim-telescope/telescope-dap.nvim',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F7>', dap.step_into)
    vim.keymap.set('n', '<F8>', dap.step_over)
    vim.keymap.set('n', '<S-F7>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      layouts = {
        {
            elements = {
                "watches",
                { id = "scopes", size = 0.5 },
                { id = "repl", size = 0.15 },
            },
            size = 79,
            position = "left",
        },
        {
            elements = {
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      element = "repl",
      controls = {
        enabled = true,
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "□",
        },
      },
    }
    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle)

    -- codelldb
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        },
    }

    dap.configurations.cpp = {
      {
          -- Change it to "cppdbg" if you have vscode-cpptools
          type = "codelldb",
          request = "launch",
          program = function ()
              -- Compile and return exec name
              local filetype = vim.bo.filetype
              local filename = vim.fn.expand("%")
              local basename = vim.fn.expand('%:t:r')
              local makefile = os.execute("(ls | grep -i makefile)")
              if makefile == "makefile" or makefile == "Makefile" then
                  os.execute("make debug")
              else
                  if filetype == "c" then
                      os.execute(string.format("gcc -g -o %s %s", basename, filename))
                  else
                      os.execute(string.format("g++ -g -o %s %s", basename, filename))
                  end
              end
              return basename
          end,
          args = function ()
              local argv = {}
              arg = vim.fn.input(string.format("argv: "))
              for a in string.gmatch(arg, "%S+") do
                  table.insert(argv, a)
              end
              vim.cmd('echo ""')
              return argv
          end,
          cwd = "${workspaceFolder}",
          -- Uncomment if you want to stop at main
          -- stopAtEntry = true,
          MIMode = "gdb",
          miDebuggerPath = "/usr/bin/gdb",
          setupCommands = {
              {
                  text = "-enable-pretty-printing",
                  description = "enable pretty printing",
                  ignoreFailures = false,
              },
          },
      },
  }

    -- You can even copy configurations
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
        {
            type = "codelldb",
            request = "launch",
            -- This is where cargo outputs the executable
            program = function ()
                --os.execute("cargo build &> /dev/null")
                os.execute("cargo build")
                return "target/debug/${workspaceFolderBasename}"
            end,
            args = function ()
                local argv = {}
                arg = vim.fn.input(string.format("argv: "))
                for a in string.gmatch(arg, "%S+") do
                    table.insert(argv, a)
                end
                return argv
            end,
            cwd = "${workspaceFolder}",
            -- Uncomment if you want to stop at main
            -- stopOnEntry = true,
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            setupCommands = {
                {
                    text = "-enable-pretty-printing",
                    description = "enable pretty printing",
                    ignoreFailures = false,
                },
            },
        },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local telescope = require("telescope")
    telescope.load_extension("dap")
  end,
}