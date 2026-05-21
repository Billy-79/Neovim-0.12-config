return {
  {
    -- Gitsigns adds Git indicators/signs in the sign column.
    --
    -- It can show added, changed, and deleted lines directly inside
    -- the editor, and also provides commands for hunks and blame.
    "lewis6991/gitsigns.nvim",

    config = function()
      -- Initialize Gitsigns with default settings.
      require("gitsigns").setup()

      -- Preview the Git hunk under the cursor.
      vim.keymap.set(
        "n",
        "<leader>gp",
        "<cmd>Gitsigns preview_hunk<CR>",
        { desc = "Gitsigns preview hunk" }
      )

      -- Toggle inline blame for the current line.
      vim.keymap.set(
        "n",
        "<leader>gt",
        "<cmd>Gitsigns toggle_current_line_blame<CR>",
        { desc = "Gitsigns toggle line blame" }
      )
    end,
  },

  {
    -- Fugitive provides powerful Git commands inside Neovim.
    --
    -- Examples:
    --   :Git (or just ":G", as ":G" it's shorthand for ":Git")
    --   :Git add
    --   :Git commit
    --   :Git push
    --   :Git status
    --   :Git blame
    --   :Gdiffsplit
    --   :Gwrite
    --   :Gread    
    "tpope/vim-fugitive",
  },
}
