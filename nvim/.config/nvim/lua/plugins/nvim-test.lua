return {
  {
    --------------------------------------------------------------------
    -- vim-test
    --------------------------------------------------------------------
    --
    -- vim-test provides a unified interface for running tests directly
    -- from Neovim.
    --
    -- It can detect and run tests for many languages/frameworks.
    --
    -- Examples:
    --   Python  -> pytest / unittest
    --   Go      -> go test
    --   Ruby    -> rspec
    --   PHP     -> phpunit
    --
    "vim-test/vim-test",

    --------------------------------------------------------------------
    -- Dependencies
    --------------------------------------------------------------------
    --
    -- Vimux allows vim-test to send test commands to a tmux pane.
    --
    -- This means test output appears in tmux instead of inside a
    -- Neovim terminal buffer.
    dependencies = {
      "preservim/vimux",
    },

    config = function()

      ------------------------------------------------------------------
      -- Test execution strategy
      ------------------------------------------------------------------
      --
      -- Strategy means:
      --   WHERE / HOW should vim-test run the test command?
      --
      -- Here we use Vimux, so tests are sent to a tmux pane.
      --
      -- Equivalent Vimscript:
      --   let test#strategy = 'vimux'
      vim.g["test#strategy"] = "vimux"

      ------------------------------------------------------------------
      -- Run nearest test
      ------------------------------------------------------------------
      --
      -- Runs the test closest to the cursor.
      --
      -- Example:
      --   If the cursor is inside test_add(),
      --   only test_add() is executed.
      vim.keymap.set(
        "n",
        "<leader>tn",
        "<cmd>TestNearest<CR>",
        { desc = "Test nearest" }
      )

      ------------------------------------------------------------------
      -- Run current test file
      ------------------------------------------------------------------
      --
      -- Runs all tests in the current file.
      vim.keymap.set(
        "n",
        "<leader>tf",
        "<cmd>TestFile<CR>",
        { desc = "Test file" }
      )

      ------------------------------------------------------------------
      -- Run entire test suite
      ------------------------------------------------------------------
      --
      -- Runs the full test suite for the current project.
      vim.keymap.set(
        "n",
        "<leader>ta",
        "<cmd>TestSuite<CR>",
        { desc = "Test suite" }
      )

      ------------------------------------------------------------------
      -- Run last test
      ------------------------------------------------------------------
      --
      -- Re-runs the most recently executed test command.
      vim.keymap.set(
        "n",
        "<leader>tl",
        "<cmd>TestLast<CR>",
        { desc = "Test last" }
      )

      ------------------------------------------------------------------
      -- Visit test output
      ------------------------------------------------------------------
      --
      -- Moves focus to the tmux pane where Vimux displayed the test
      -- output.
      vim.keymap.set(
        "n",
        "<leader>tv",
        "<cmd>TestVisit<CR>",
        { desc = "Test visit" }
      )
    end,
  },
}
