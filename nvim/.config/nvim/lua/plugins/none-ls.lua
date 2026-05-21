return {
  {
    -- Mason integration for none-ls.
    --
    -- Automatically installs formatters and linters
    -- used by none-ls.
    "jay-babu/mason-null-ls.nvim",

    dependencies = {
      -- Mason package manager.
      "mason-org/mason.nvim",

      -- none-ls core plugin.
      "nvimtools/none-ls.nvim",
    },

    opts = {
      -- Tools Mason should automatically install.
      ensure_installed = {
        -- Lua formatter
        "stylua",

        -- JavaScript / TypeScript / JSON / HTML / CSS formatter
        "prettier",

        -- Python formatter
        "black",

        -- Python import sorter
        "isort",

        -- Ruby formatter/linter
        "rubocop",

        -- ERB linter
        "erb-lint",
      },

      -- Automatically install configured tools if missing.
      automatic_installation = true,
    },
  },

  {
    -- none-ls allows external formatters and linters
    -- to integrate into Neovim's built-in LSP system.
    --
    -- Formerly known as null-ls.
    "nvimtools/none-ls.nvim",

    config = function()

      -- Load none-ls module.
      --
      -- The Lua module name remains "null-ls"
      -- for backward compatibility.
      local null_ls = require("null-ls")

      -- Configure none-ls.
      null_ls.setup({

        -- Register formatting and diagnostic sources.
        sources = {

          --------------------------------------------------------------
          -- Formatting sources
          --------------------------------------------------------------

          -- Lua formatter
          null_ls.builtins.formatting.stylua,

          -- JS/TS/HTML/CSS/JSON formatter
          null_ls.builtins.formatting.prettier,

          -- Python formatter
          null_ls.builtins.formatting.black,

          -- Python import sorter
          null_ls.builtins.formatting.isort,

          -- Ruby formatter
          null_ls.builtins.formatting.rubocop,

          --------------------------------------------------------------
          -- Diagnostic sources
          --------------------------------------------------------------

          -- Ruby diagnostics/linting
          null_ls.builtins.diagnostics.rubocop,

          -- ERB diagnostics/linting
          null_ls.builtins.diagnostics.erb_lint,
        },

        -- Runs when none-ls attaches to a buffer.
        on_attach = function(_client, bufnr)

          -- Create a buffer-local formatting keymap.
          vim.keymap.set(
            "n",
            "<leader>gf",

            -- Run LSP formatting.
            vim.lsp.buf.format,

            {
              -- Restrict keymap to current buffer.
              buffer = bufnr,

              -- Keymap description.
              desc = "Format buffer",
            }
          )
        end,
      })
    end,
  },
}
