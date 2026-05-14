return {
  {
    "jay-babu/mason-null-ls.nvim",
    
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "black",
        "isort",
        "rubocop",
        "erb-lint",
      },
      
      automatic_installation = true,
    },
  },  

  {
    "nvimtools/none-ls.nvim",
  
    config = function()
      local null_ls = require("null-ls")
    
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
        
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rubocop,
        
          null_ls.builtins.diagnostics.erb_lint,
        },
    
        on_attach = function(_client, bufnr)
          vim.keymap.set(
            "n", 
            "<leader>gf", 
            vim.lsp.buf.format, 
            { 
              buffer = bufnr, 
              desc = "Format buffer", 
            }
          )
        end,
      })  
    end,
  },
}
