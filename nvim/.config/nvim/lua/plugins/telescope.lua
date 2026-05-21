return {
  {
    -- Telescope fuzzy finder plugin.
    --
    -- Telescope provides:
    --   file searching
    --   live grep searching
    --   buffers
    --   help tags
    --   Git integration
    --   LSP pickers
    --   and more.
    "nvim-telescope/telescope.nvim",

    -- Use the latest stable version.
    version = "*",

    dependencies = {

      -- Utility functions required by Telescope.
      "nvim-lua/plenary.nvim",

      {
        -- Native FZF sorter extension for Telescope.
        --
        -- Improves sorting and search performance.
        "nvim-telescope/telescope-fzf-native.nvim",

        -- Build the native extension using make.
        build = "make",
      },

      -- Replaces certain Vim UI selections with Telescope pickers.
      --
      -- Examples:
      --   vim.ui.select()
      --   code actions
      --   some plugin menus
      "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()

      -- Load Telescope core module.
      local telescope = require("telescope")

      -- Load built-in Telescope pickers.
      local builtin = require("telescope.builtin")

      -- Configure Telescope.
      telescope.setup({

        -- Configure Telescope extensions.
        extensions = {

          -- Configure the ui-select extension.
          --
          -- Uses a dropdown-style Telescope UI.
          ["ui-select"] =
            require("telescope.themes").get_dropdown({}),
        },
      })

      -- Enable the ui-select extension.
      telescope.load_extension("ui-select")

      -- Enable the native FZF extension.
      telescope.load_extension("fzf")

      ------------------------------------------------------------------
      -- Telescope keymaps
      ------------------------------------------------------------------

      -- Open Telescope file finder.
      vim.keymap.set(
        "n",
        "<leader>ff",
        builtin.find_files,
        { desc = "Telescope find files" }
      )

      -- Open Telescope live grep search.
      vim.keymap.set(
        "n",
        "<leader>fg",
        builtin.live_grep,
        { desc = "Telescope live grep" }
      )
    end,
  },
}
