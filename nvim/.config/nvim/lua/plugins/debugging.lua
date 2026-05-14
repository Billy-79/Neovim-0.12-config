return {
  {
    "mfussenegger/nvim-dap",
    
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      dapui.setup()
      require("dap-go").setup()
      
      dap_python.setup("python3")
      dap_python.test_runner = "pytest"

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

      vim.keymap.set(
        "n", 
        "<Leader>dt", 
        dap.toggle_breakpoint, 
        { desc = "DAP toggle breakpoint" }
      )
      vim.keymap.set(
        "n", 
        "<Leader>dc", 
        dap.continue, 
        { desc = "DAP continue" }
      )
    end,
  },
}
