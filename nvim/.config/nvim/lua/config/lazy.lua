-- Define the installation path for Lazy.nvim.
--
-- `stdpath("data")` usually resolves to:
--   ~/.local/share/nvim
--
-- So the final path becomes something like:
--   ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check whether Lazy.nvim already exists at the installation path.
--
-- `vim.uv` is the newer Neovim async API.
-- `vim.loop` is the older compatibility fallback.
--
-- `fs_stat()` checks whether the directory/file exists.
if not (vim.uv or vim.loop).fs_stat(lazypath) then

  -- Git repository URL for Lazy.nvim
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  -- Clone Lazy.nvim from GitHub.
  --
  -- `--filter=blob:none`
  --   speeds up cloning by excluding unnecessary Git objects.
  --
  -- `--branch=stable`
  --   installs the stable release branch.
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  -- Check whether the git clone operation failed.
  if vim.v.shell_error ~= 0 then

    -- Display a formatted error message inside Neovim.
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    -- Wait for user input before closing.
    vim.fn.getchar()

    -- Exit Neovim with error code 1.
    os.exit(1)
  end
end

-- Add Lazy.nvim to Neovim's runtime path.
--
-- This allows Neovim to load the plugin manager itself.
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------
-- General Neovim editor settings
----------------------------------------------------------------------

-- Convert tabs into spaces
vim.opt.expandtab = true

-- Number of spaces a real tab character represents
vim.opt.tabstop = 2

-- Number of spaces inserted when pressing Tab in insert mode
vim.opt.softtabstop = 2

-- Number of spaces used for autoindent operations
vim.opt.shiftwidth = 2

-- Enable absolute line numbers
vim.opt.number = true

-- Keep folds open when opening files
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

----------------------------------------------------------------------
-- Leader key configuration
----------------------------------------------------------------------

-- Main leader key
--
-- Used for custom shortcuts like:
--   <leader>ff
--   <leader>gd
--
-- Here it is set to Space.
vim.g.mapleader = " "

-- Local leader key
--
-- Used less commonly for filetype-specific mappings.
vim.g.maplocalleader = "\\"

----------------------------------------------------------------------
-- Lazy.nvim setup
----------------------------------------------------------------------

require("lazy").setup({

  -- Plugin specification imports
  --
  -- This loads all plugin files from:
  --   lua/plugins/
  spec = {
    { import = "plugins" },
  },

  -- Automatically install the Catppuccin colorscheme
  -- if no colorscheme is installed yet.
  install = {
    colorscheme = { "catppuccin" },
  },

  -- Enable automatic plugin update checking.
  --
  -- Lazy.nvim will periodically check for available updates.
  checker = {
    enabled = true,
  },
})
