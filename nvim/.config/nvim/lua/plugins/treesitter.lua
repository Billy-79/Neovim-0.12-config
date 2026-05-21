return {
  {
    -- Treesitter plugin.
    --
    -- Provides parser installation and query files for syntax-aware
    -- features in Neovim.
    "nvim-treesitter/nvim-treesitter",

    -- Use the new main branch.
    --
    -- This branch follows the newer Neovim 0.12-style Treesitter setup.
    branch = "main",

    -- Load Treesitter immediately.
    lazy = false,

    -- Update installed parsers when the plugin updates.
    build = ":TSUpdate",

    config = function()
      -- Configure nvim-treesitter.
      require("nvim-treesitter").setup({
        -- Directory where Treesitter parsers are installed.
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Install the listed Treesitter parsers.
      require("nvim-treesitter").install({
        "awk",
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "ruby",
        "rust",
        "sql",
        "toml",
        "typescript",
        "xml",
        "yaml",
        "zig",
      })

      -- Run whenever Neovim detects a filetype.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- Start Treesitter for the current buffer.
          --
          -- `pcall` prevents errors if no parser exists for a filetype.
          pcall(vim.treesitter.start, args.buf)

          -- Enable Treesitter-based folding for the current window.
          --
          -- Your global foldlevel/foldlevelstart settings keep files
          -- open by default, while still allowing manual folds.
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
