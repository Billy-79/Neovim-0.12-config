return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      
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
        
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          
          -- Treesitter-based folding provided by Neovim.
          --vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          --vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
