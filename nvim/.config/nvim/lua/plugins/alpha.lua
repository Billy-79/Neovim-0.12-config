-- Return a Lazy.nvim plugin specification table
return {
  {
    -- Alpha.nvim plugin
    --
    -- Provides a customizable startup/dashboard screen for Neovim.
    "goolord/alpha-nvim",

    -- Plugin dependencies
    dependencies = {

      -- Provides Nerd Font icons used in dashboard buttons/UI.
      "nvim-tree/nvim-web-devicons",
    },

    -- Plugin configuration function
    config = function()

      -- Load Alpha.nvim core module
      local alpha = require("alpha")

      -- Load Alpha's built-in dashboard theme
      local dashboard = require("alpha.themes.dashboard")

      ------------------------------------------------------------------
      -- Dashboard Header
      ------------------------------------------------------------------

      -- ASCII / Unicode logo displayed at the top of the dashboard.
      --
      -- `dashboard.section.header.val`
      -- defines the actual text lines shown.
      dashboard.section.header.val = {
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      }

      ------------------------------------------------------------------
      -- Header Styling Options
      ------------------------------------------------------------------

      dashboard.section.header.opts = {

        -- Center the header horizontally
        position = "center",

        -- Use the "Type" highlight group for the header colors
        hl = "Type",
      }

      ------------------------------------------------------------------
      -- Dashboard Buttons
      ------------------------------------------------------------------

      -- Buttons displayed below the header.
      --
      -- Format:
      -- dashboard.button(shortcut, label, command)
      dashboard.section.buttons.val = {

        -- Create a new empty buffer and immediately enter insert mode
        dashboard.button(
          "e",
          "   New file",
          ":ene <BAR> startinsert <CR>"
        ),

        -- Open Telescope file finder
        dashboard.button(
          "f",
          "   Find file",
          ":Telescope find_files<CR>"
        ),

        -- Open Telescope live grep search
        dashboard.button(
          "g",
          "󰱼   Find word",
          ":Telescope live_grep<CR>"
        ),

        -- Show recently opened files
        dashboard.button(
          "r",
          "   Recent",
          ":Telescope oldfiles<CR>"
        ),

        -- Open Neovim config file
        dashboard.button(
          "c",
          "   Config",
          ":e $MYVIMRC <CR>"
        ),

        -- Open Mason package manager
        dashboard.button(
          "m",
          "󱌣   Mason",
          ":Mason<CR>"
        ),

        -- Open Lazy.nvim UI
        dashboard.button(
          "l",
          "󰒲   Lazy",
          ":Lazy<CR>"
        ),

        -- Synchronize/update plugins
        dashboard.button(
          "u",
          "󰂖   Update plugins",
          "<cmd>Lazy sync<CR>"
        ),

        -- Quit Neovim
        dashboard.button(
          "q",
          "   Quit NVIM",
          ":qa<CR>"
        ),
      }

      ------------------------------------------------------------------
      -- Initialize Alpha dashboard
      ------------------------------------------------------------------

      -- Apply the dashboard configuration and start Alpha.nvim
      alpha.setup(dashboard.opts)
    end,
  },
}
