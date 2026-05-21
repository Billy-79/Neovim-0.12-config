return {
  {
    -- Completion source for Neovim LSP.
    --
    -- This lets nvim-cmp receive completion items from language servers
    -- such as pyright, lua_ls, clangd, rust_analyzer, etc.
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    -- Completion source for words already present in the current buffer.
    "hrsh7th/cmp-buffer",
  },

  {
    -- LuaSnip snippet engine.
    --
    -- nvim-cmp uses this to expand snippets returned by LSPs
    -- or snippet collections.
    "L3MON4D3/LuaSnip",

    -- Use LuaSnip v2 releases.
    version = "v2.*",

    dependencies = {
      -- Allows nvim-cmp to show LuaSnip snippets as completion items.
      "saadparwaiz1/cmp_luasnip",

      -- Collection of ready-made snippets in VSCode snippet format.
      "rafamadriz/friendly-snippets",
    },
  },

  {
    -- Main completion engine.
    "hrsh7th/nvim-cmp",

    config = function()
      -- Load nvim-cmp.
      local cmp = require("cmp")

      -- Load snippets from friendly-snippets lazily.
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- Tell nvim-cmp how to expand snippets.
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        -- Add borders around completion and documentation windows.
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Completion key mappings used while typing.
        mapping = cmp.mapping.preset.insert({
          -- Scroll documentation window up.
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),

          -- Scroll documentation window down.
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Manually trigger completion menu.
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Close/abort the completion menu.
          ["<C-e>"] = cmp.mapping.abort(),

          -- Confirm selected completion item.
          --
          -- `select = true` means if nothing is explicitly selected,
          -- nvim-cmp will confirm the first item.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        -- Completion sources.
        sources = cmp.config.sources({
          -- First priority group:
          -- LSP completions and snippets.
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          -- Second priority group:
          -- words from the current buffer.
          { name = "buffer" },
        }),
      })
    end,
  },
}
