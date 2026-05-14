return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "html",
        "ansiblels",
        "awk_ls", 
        "pyright", 
        "gopls",
        "bashls",
        "clangd",
        "cssls",
        "jdtls",
        "jsonls",
        "intelephense",
        "ruby_lsp",
        "rust_analyzer",
        "sqlls",
        "taplo",
        "lemminx",
        "yamlls",
        "zls",
      },
    },
    
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },  
  },

  {
    "neovim/nvim-lspconfig",
    
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },  
    
    config = function()
      local capabilities = 
        require("cmp_nvim_lsp").default_capabilities()
      
      local servers = {
        "lua_ls",
        "ts_ls",
        "html",
        "ansiblels",
        "awk_ls",
        "pyright",
        "gopls",
        "bashls",
        "clangd",
        "cssls",
        "jdtls",
        "jsonls",
        "intelephense",
        "ruby_lsp",
        "rust_analyzer",
        "sqlls",
        "taplo",
        "lemminx",
        "yamlls",
        "zls",
      }
      
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end
      
      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
