return {
  {
    "stevearc/oil.nvim",
    
    dependencies = { 
      "nvim-tree/nvim-web-devicons", 
    },
    
    lazy = false,

    config = function()
      local oil = require("oil")
    
      oil.setup({
        view_options = {
          show_hidden = false,
        },
      })
    
      vim.keymap.set(
        "n", 
        "<leader>-", 
        oil.toggle_float, 
        { desc = "Open Oil floating file explorer" }
      )
    end,
  },
}
