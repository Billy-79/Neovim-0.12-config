return {
  {
    -- Core Debug Adapter Protocol plugin for Neovim.
    --
    -- This provides the main debugging engine.
    "mfussenegger/nvim-dap",

    dependencies = {
      -- UI panels for nvim-dap:
      -- variables, scopes, stack trace, watches, REPL, etc.
      "rcarriga/nvim-dap-ui",

      -- Go-specific DAP helper.
      --
      -- Integrates nvim-dap with Delve.
      "leoluz/nvim-dap-go",

      -- Python-specific DAP helper.
      --
      -- Integrates nvim-dap with debugpy.
      "mfussenegger/nvim-dap-python",

      -- Async dependency required by nvim-dap-ui.
      "nvim-neotest/nvim-nio",
    },

    config = function()
      -- Load core DAP module.
      local dap = require("dap")

      -- Load DAP UI module.
      local dapui = require("dapui")

      -- Load Python DAP helper module.
      local dap_python = require("dap-python")

      -- Initialize DAP UI.
      dapui.setup()

      -- Initialize Go debugging support.
      require("dap-go").setup()

      -- Initialize Python debugging support.
      --
      -- "python3" should point to your Python executable.
      dap_python.setup("python3")

      -- Use pytest as the test runner for dap-python test debugging.
      dap_python.test_runner = "pytest"

      -- Open the DAP UI before attaching to a running debug target.
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      -- Open the DAP UI before launching a new debug session.
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      -- Close the DAP UI before the debug session terminates.
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      -- Close the DAP UI before the debug session exits.
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Toggle a breakpoint on the current line.
      vim.keymap.set(
        "n",
        "<Leader>dt",
        dap.toggle_breakpoint,
        { desc = "DAP toggle breakpoint" }
      )

      -- Start or continue a debug session.
      vim.keymap.set(
        "n",
        "<Leader>dc",
        dap.continue,
        { desc = "DAP continue" }
      )
    end,
  },
}
