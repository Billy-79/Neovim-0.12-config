return {
  {
    -- Oil.nvim file explorer.
    --
    -- Oil lets you edit directories like regular buffers.
    -- You can create, rename, move, and delete files using normal
    -- Neovim editing actions.
    "stevearc/oil.nvim",

    dependencies = {
      -- Provides file and folder icons.
      "nvim-tree/nvim-web-devicons",
    },

    -- Load Oil immediately.
    lazy = false,

    config = function()
      -- Load Oil module.
      local oil = require("oil")

      -- Configure Oil.
      oil.setup({
        view_options = {
          -- Show hidden files, such as:
          --   .gitignore
          --   .env
          --   .config
          show_hidden = true,
        },
      })

      -- Open Oil in a floating file explorer window.
      vim.keymap.set(
        "n",
        "<leader>-",
        oil.toggle_float,
        { desc = "Open Oil floating file explorer" }
      )
    end,
  },
}
