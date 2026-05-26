return {
  {
    -- Plugin repository
    --
    -- vim-tmux-navigator allows seamless navigation between:
    --   * Neovim split windows
    --   * tmux panes
    --
    -- Using the same keybindings.
    --
    -- Example:
    --   <C-h>  move left
    --   <C-j>  move down
    --   <C-k>  move up
    --   <C-l>  move right
    --
    -- If a Neovim split exists in that direction,
    -- navigation stays inside Neovim.
    --
    -- Otherwise the movement is forwarded to tmux.
    "christoomey/vim-tmux-navigator",

    config = function()

      --------------------------------------------------------------------
      -- Navigate left
      --------------------------------------------------------------------
      --
      -- Moves to:
      --   * left Neovim split
      --   * or left tmux pane
      --
      vim.keymap.set(
        "n",
        "<C-h>",
        "<cmd>TmuxNavigateLeft<CR>",
        { desc = "Navigate left" }
      )

      --------------------------------------------------------------------
      -- Navigate down
      --------------------------------------------------------------------
      --
      -- Moves to:
      --   * lower Neovim split
      --   * or lower tmux pane
      --
      vim.keymap.set(
        "n",
        "<C-j>",
        "<cmd>TmuxNavigateDown<CR>",
        { desc = "Navigate down" }
      )

      --------------------------------------------------------------------
      -- Navigate up
      --------------------------------------------------------------------
      --
      -- Moves to:
      --   * upper Neovim split
      --   * or upper tmux pane
      --
      vim.keymap.set(
        "n",
        "<C-k>",
        "<cmd>TmuxNavigateUp<CR>",
        { desc = "Navigate up" }
      )

      --------------------------------------------------------------------
      -- Navigate right
      --------------------------------------------------------------------
      --
      -- Moves to:
      --   * right Neovim split
      --   * or right tmux pane
      --
      vim.keymap.set(
        "n",
        "<C-l>",
        "<cmd>TmuxNavigateRight<CR>",
        { desc = "Navigate right" }
      )
    end,
  },
}
