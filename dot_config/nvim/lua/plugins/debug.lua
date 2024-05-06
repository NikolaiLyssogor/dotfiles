return {
  {
    "mfussenegger/nvim-dap",
    commit = "405df1dcc2e395ab5173a9c3d00e03942c023074",
    pin = true,
    event = "VeryLazy",
    config = function()
      local dap = require("dap")

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
        name = "lldb",
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      require("which-key").register({
        d = {
          name = "[d]ebugging",
          b = { ":DapToggleBreakpoint<cr>", "[b]reakponit toggle" },
          c = { ":DapContinue<cr>", "[c]ontinue" },
          t = { ":DapTerminate<cr>", "[t]erminate" },
          r = { ":DapToggleRepl<cr>", "[r]epl toggle" },
        },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    tag = "v4.0.0",
    pin = true,
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      dapui.setup()
    end,
  },
}
