return {
  {
    -- Neo-tree file explorer plugin.
    --
    -- Provides a tree-style file browser inside Neovim.
    "nvim-neo-tree/neo-tree.nvim",

    -- Use the stable v3.x branch.
    branch = "v3.x",

    dependencies = {
      -- Utility Lua functions used by many Neovim plugins.
      "nvim-lua/plenary.nvim",

      -- UI component library required by Neo-tree.
      "MunifTanjim/nui.nvim",

      -- Provides file and folder icons.
      "nvim-tree/nvim-web-devicons",
    },

    -- Load Neo-tree immediately on startup.
    lazy = false,

    config = function()
      -- Configure Neo-tree.
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            -- Allows filtered/hidden items to be toggled visible.
            visible = true,

            -- Show dotfiles such as .gitignore, .env, .config, etc.
            hide_dotfiles = false,

            -- Keep Git-ignored files hidden.
            hide_gitignored = true,
          },
        },
      })

      -- Open Neo-tree on the left and reveal the current file.
      vim.keymap.set(
        "n",
        "<C-n>",
        "<cmd>Neotree filesystem reveal left<CR>",
        { desc = "Neo-tree reveal" }
      )
    end,
  },
}
