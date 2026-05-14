return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

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

      dashboard.section.header.opts = {
        position = "center",
        hl = "Type",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
        dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
        dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("c", "   Config", ":e $MYVIMRC <CR>"),
        dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
        dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
        dashboard.button("u", "󰂖   Update plugins", "<cmd>Lazy sync<CR>"),
        dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)
    end,
  },
}
