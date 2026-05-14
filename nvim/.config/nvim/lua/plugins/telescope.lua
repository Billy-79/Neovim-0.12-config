return {
  {
    "nvim-telescope/telescope.nvim", 
    version = "*",
    
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make", 
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      
      telescope.setup({
        extensions = {
          ["ui-select"] = 
            require("telescope.themes").get_dropdown({}),
        },
      })
      
      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
      
      vim.keymap.set(
        "n", 
        "<leader>ff", 
        builtin.find_files, 
        { desc = "Telescope find files" }
      )
        
      vim.keymap.set(
        "n", 
        "<leader>fg", 
        builtin.live_grep, 
        { desc = "Telescope live grep" }
      )
    end,
  },
}
