return {
  {
    -- Lualine statusline plugin.
    --
    -- This replaces Neovim's default statusline with a modern,
    -- configurable statusline.
    "nvim-lualine/lualine.nvim",

    dependencies = {
      -- Provides filetype icons used by lualine.
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      -- Configure lualine.
      require("lualine").setup({
        options = {
          -- Enable icons in the statusline.
          icons_enabled = true,

          -- Use the Dracula lualine theme.
          theme = "dracula",

          -- Separators between smaller components inside sections.
          --
          -- Example:
          --   filename  encoding  filetype
          component_separators = {
            left = "",
            right = "",
          },

          -- Separators between major lualine sections.
          --
          -- These create the classic Powerline-style look.
          section_separators = {
            left = "",
            right = "",
          },
        },
      })
    end,
  },
}
