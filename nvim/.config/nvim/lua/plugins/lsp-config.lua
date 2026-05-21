return {
  {
    -- Mason.nvim installs external developer tools for Neovim,
    -- such as LSP servers, formatters, linters, and debuggers.
    "mason-org/mason.nvim",

    opts = {
      ui = {
        icons = {
          -- Icon shown when a package is installed.
          package_installed = "✓",

          -- Icon shown when a package is being installed or updated.
          package_pending = "➜",

          -- Icon shown when a package is not installed.
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    -- mason-lspconfig connects Mason with nvim-lspconfig.
    --
    -- Mason handles installation.
    -- nvim-lspconfig handles LSP configuration.
    "mason-org/mason-lspconfig.nvim",

    opts = {
      -- Ensure these LSP servers are installed by Mason.
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
    -- nvim-lspconfig provides configurations for Neovim's built-in LSP client.
    "neovim/nvim-lspconfig",

    dependencies = {
      -- Adds nvim-cmp completion capabilities to LSP servers.
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      -- Get enhanced LSP capabilities for nvim-cmp completion.
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      -- List of all LSP servers used by this setup.
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

      -- Configure every server in the list.
      for _, server in ipairs(servers) do
        if server == "lua_ls" then
          -- Special LuaLS configuration.
          --
          -- Neovim provides a global variable called `vim`.
          -- Standard Lua does not know about it, so LuaLS can warn:
          --   Undefined global 'vim'
          --
          -- This tells LuaLS that `vim` is a valid global.
          vim.lsp.config("lua_ls", {
            capabilities = capabilities,

            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        else
          -- Generic configuration for all other LSP servers.
          vim.lsp.config(server, {
            capabilities = capabilities,
          })
        end
      end

      -- Enable all configured LSP servers.
      vim.lsp.enable(servers)

      -- Create keymaps when an LSP attaches to a buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          -- Make mappings buffer-local.
          local opts = { buffer = event.buf }

          -- Show hover documentation.
          vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)

          -- Jump to definition.
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)

          -- Show references.
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)

          -- Show code actions.
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
