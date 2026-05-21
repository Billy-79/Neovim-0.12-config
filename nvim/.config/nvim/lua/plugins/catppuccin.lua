return {
  {
    -- Catppuccin colorscheme plugin.
    --
    -- The actual GitHub repository is:
    --   catppuccin/nvim
    "catppuccin/nvim",

    -- Load immediately instead of lazy-loading.
    --
    -- Colorschemes should usually load early so the UI is styled
    -- as soon as Neovim starts.
    lazy = false,

    -- Give the plugin a local name.
    --
    -- This lets Lazy.nvim refer to it as "catppuccin"
    -- instead of "nvim".
    name = "catppuccin",

    -- Load priority.
    --
    -- A high priority ensures the colorscheme loads before
    -- most other visual/UI plugins.
    priority = 1000,

    config = function()
      -- Configure Catppuccin before applying the colorscheme.
      require("catppuccin").setup({
        -- Use the Mocha variant, which is the darkest Catppuccin flavour.
        flavour = "mocha",

        -- Make Neovim use a transparent background.
        transparent_background = true,

        -- Automatically enable integrations for supported plugins.
        auto_integrations = true,
      })

      -- Apply the Catppuccin Mocha colorscheme.
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
