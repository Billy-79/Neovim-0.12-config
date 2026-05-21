###################################### README STARTS HERE #######################################


PROJECT STRUCTURE

~/.config/nvim
├── init.lua
├── lua
│   ├── config
│   │   └── lazy.lua
│   └── plugins
│       ├── alpha.lua
│       ├── catppuccin.lua
│       ├── completions.lua
│       ├── debugging.lua
│       ├── git-integration.lua
│       ├── lsp-config.lua
│       ├── lualine.lua
│       ├── neo-tree.lua
│       ├── none-ls.lua
│       ├── oil.lua
│       ├── telescope.lua
│       └── treesitter.lua
└── plugin
    └── floaterminal.lua


#########################################################################################################


Required packages that should be installed for Arch Linux

Execute the following command: 

	sudo pacman -S --needed base-devel npm nodejs php git curl clang jdk-openjdk tar gzip delve go	
	python-debugpy ripgrep rubygems ruby rustup zig fzf unzip fd tree-sitter-cli

Next, initialize Rust by executing:

	rustup default stable

Finally we will also need to install a Nerd Font Family:

	sudo pacman -S ttf-meslo-nerd


#########################################################################################################


~/.config/nvim/init.lua


Segment-by-Segment Analysis

---------------------------------------------------------------------------------------------------------

The init.lua is intentionally minimal as it follows the structured setup, which is better for maintainability.

This line:

	require("config.lazy")

loads our Lazy.nvim setup from:

	lua/config/lazy.lua
	
So our startup flow is:

	init.lua
	  → lua/config/lazy.lua
	    → lua/plugins/*.lua

This keeps init.lua clean and delegates plugin loading/configuration to the 
proper modular files.


#########################################################################################################


~/.config/nvim/lua/config/lazy.lua


Segment-by-Segment Analysis

---------------------------------------------------------------------------------------------------------

1. Lazy.nvim Bootstrap

	local lazypath = ...

This section ensures:

  * Lazy.nvim exists locally
  * if not, it gets automatically cloned from GitHub

This is the standard modern Lazy.nvim bootstrap process.

---------------------------------------------------------------------------------------------------------

2. Filesystem Check

	(vim.uv or vim.loop).fs_stat(...)

Checks whether:

	lazy.nvim

already exists on disk.

This supports both:

  * newer Neovim APIs (vim.uv)
  * older compatibility (vim.loop)

Good modern compatibility approach.

---------------------------------------------------------------------------------------------------------

3. Automatic Git Clone

	git clone --filter=blob:none --branch=stable

Efficient clone strategy:

  * stable branch
  * minimal Git data
  * faster installation

---------------------------------------------------------------------------------------------------------

4. Error Handling

	vim.api.nvim_echo(...)

If cloning fails:

  * prints formatted errors
  * waits for user input
  * exits safely

Good defensive programming.

---------------------------------------------------------------------------------------------------------

5. Runtime Path Injection

	vim.opt.rtp:prepend(lazypath)

Adds Lazy.nvim into Neovim’s runtime path so it can be loaded.

Without this:

	require("lazy")

would fail.

---------------------------------------------------------------------------------------------------------

6. Editor Settings

	vim.opt.expandtab = true
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth = 2

Controls indentation behavior.

Our setup means:

  * tabs become spaces
  * indentation width = 2 spaces

---------------------------------------------------------------------------------------------------------

7. Line Numbers

	vim.opt.number = true

Enables absolute line numbers.

---------------------------------------------------------------------------------------------------------

8. Fold-related Options

	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99

vim.opt.foldlevel = 99

This controls how many fold levels remain open while editing.

A high value like 99 means:

Keep almost all folds open.

So even if folding is enabled elsewhere, our code will not suddenly appear collapsed during normal editing.

------------------------------------------------------------------------

vim.opt.foldlevelstart = 99

This controls the fold level when a file is first opened.

A high value like 99 means:

Open files with folds expanded.

So files will not open with hidden/collapsed code.

------------------------------------------------------------------------

These options let us keep folding support available without the annoying behavior of opening files with collapsed code.

So later, if we enable Treesitter folding, we can still manually fold code with:

- Key -		------- Action -------
zc		close fold
zo		open fold
za		toggle fold
zM		close all folds
zR		open all folds
zj		jump to next fold
zk		jump to previous fold

---------------------------------------------------------------------------------------------------------

9. Leader Keys

	vim.g.mapleader = " "

Sets:

  * Space as the main leader key
  * \ as local leader

This powers our mappings like:

  * <leader>ff
  * <leader>dc
  * <leader>gp
  
---------------------------------------------------------------------------------------------------------

10. Lazy.nvim Setup

	require("lazy").setup(...)

Main plugin manager initialization.

------------------------------------------------------------------------

Plugin Import System

	spec = {
	  { import = "plugins" },
	}

Automatically loads:

	lua/plugins/*.lua

This is why our modular plugin structure works.

------------------------------------------------------------------------

Colorscheme Auto-install

	install = {
	  colorscheme = { "catppuccin" },
	}

Ensures that Catppuccin gets installed automatically on first startup.

------------------------------------------------------------------------

Plugin Update Checker

	checker = {
	  enabled = true,
	}

Enables automatic plugin update checks.


#########################################################################################################


~/.config/nvim/lua/plugins/alpha.lua


Segment-by-Segment Analysis

---------------------------------------------------------------------------------------------------------

1. Plugin Declaration

	{
	  "goolord/alpha-nvim",
	}

Declares the Alpha.nvim plugin for Lazy.nvim.

Alpha provides:

  * startup screen
  * dashboard UI
  * custom buttons
  * ASCII logos
  * session/startup integration

---------------------------------------------------------------------------------------------------------

2. Dependencies

	dependencies = {
	  "nvim-tree/nvim-web-devicons",
	}

Loads Nerd Font icons support.

Without this:

many icons in the dashboard buttons would not render properly.

---------------------------------------------------------------------------------------------------------

3. Module Loading

	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

Loads:

  * Alpha core
  * the built-in dashboard theme

Alpha has multiple themes/layouts, but dashboard is the most common.

---------------------------------------------------------------------------------------------------------

4. Header Section

	dashboard.section.header.val = {
	  ...
	}

Defines the large ASCII/Unicode logo at startup.

Each string in the table becomes one rendered line.

---------------------------------------------------------------------------------------------------------

5. Header Styling

	dashboard.section.header.opts = {
	  position = "center",
	  hl = "Type",
	}

Controls:

  * alignment
  * highlight colors

------------------------------------------------------------------------

	position = "center"

Centers the logo horizontally.

------------------------------------------------------------------------

	hl = "Type"

Uses Neovim’s "Type" highlight group.

Our colorscheme determines the actual color.

---------------------------------------------------------------------------------------------------------

6. Dashboard Buttons

	dashboard.section.buttons.val = {
	  ...
	}

Creates interactive dashboard actions.

Each button contains:

  * keyboard shortcut
  * icon/text label
  * command to execute

---------------------------------------------------------------------------------------------------------

7. New File Button

	":ene <BAR> startinsert <CR>"

Breakdown:

- Command -	---------- Meaning ----------
:ene		create new empty buffer
<BAR>		command separator
startinsert	immediately enter insert mode
<CR>		press Enter key automatically

---------------------------------------------------------------------------------------------------------

8. Telescope Buttons

	:Telescope find_files
	:Telescope live_grep
	:Telescope oldfiles

Integrates Alpha with Telescope.

---------------------------------------------------------------------------------------------------------

9. Config Button

	:e $MYVIMRC

Opens "init.lua" or the main Neovim config entrypoint.

---------------------------------------------------------------------------------------------------------

10. Mason / Lazy Buttons

	:Mason
	:Lazy

Quick access to:

  * LSP/tool manager
  * plugin manager

---------------------------------------------------------------------------------------------------------

11. Plugin Update Button

	<cmd>Lazy sync<CR>

Performs:

  * plugin installation
  * updates
  * cleanup
  * synchronization

---------------------------------------------------------------------------------------------------------

12. Quit Button

	:qa

Quits all windows and exits Neovim.

---------------------------------------------------------------------------------------------------------

13. Dashboard Initialization

	alpha.setup(dashboard.opts)

Finalizes and activates the dashboard configuration.

Without this nothing would render.


#########################################################################################################


~/.config/nvim/lua/plugins/catppuccin.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

Plugin declaration

	"catppuccin/nvim"

Installs the Catppuccin colorscheme plugin.

------------------------------------------------------------------------

Early loading

	lazy = false
	priority = 1000

This is correct for a colorscheme. It makes Catppuccin load early, before UI plugins like lualine, neo-tree, telescope, and alpha.

------------------------------------------------------------------------

Plugin rename

	name = "catppuccin"

Useful because the repo name is nvim, but we want the plugin identified as catppuccin.

------------------------------------------------------------------------

Setup block

	require("catppuccin").setup({...})

Configures Catppuccin before applying it.

------------------------------------------------------------------------

Mocha flavour

	flavour = "mocha"

Uses the darkest Catppuccin theme variant.

------------------------------------------------------------------------

Transparent background

	transparent_background = true

Lets our terminal background show through Neovim.

------------------------------------------------------------------------

Auto integrations

	auto_integrations = true

Catppuccin will automatically style supported plugins where possible.

------------------------------------------------------------------------

Apply colorscheme

	vim.cmd.colorscheme("catppuccin-mocha")

This is the modern Lua-friendly form of:

	:colorscheme catppuccin-mocha


#########################################################################################################


~/.config/nvim/lua/plugins/completions.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

cmp-nvim-lsp

	"hrsh7th/cmp-nvim-lsp"

This connects nvim-cmp with Neovim’s LSP clients. Without it, language-server completions would not be available through nvim-cmp.

------------------------------------------------------------------------

cmp-buffer

	"hrsh7th/cmp-buffer"

This adds suggestions from words already present in the current file.

------------------------------------------------------------------------

LuaSnip

	"L3MON4D3/LuaSnip"

This is our snippet engine. It expands snippets when an LSP or snippet source returns snippet-style completion items.

------------------------------------------------------------------------

cmp_luasnip

	"saadparwaiz1/cmp_luasnip"

This makes LuaSnip snippets appear inside the nvim-cmp completion menu.

------------------------------------------------------------------------

friendly-snippets

	"rafamadriz/friendly-snippets"

This provides a large set of ready-made snippets for many languages.

------------------------------------------------------------------------

Lazy snippet loading

	require("luasnip.loaders.from_vscode").lazy_load()

Loads VSCode-format snippets only when needed, instead of loading everything immediately at startup.

------------------------------------------------------------------------

Snippet expansion

	require("luasnip").lsp_expand(args.body)

This tells nvim-cmp how to expand snippet text when a completion item contains snippet placeholders.

------------------------------------------------------------------------

Completion windows

	completion = cmp.config.window.bordered()
	documentation = cmp.config.window.bordered()

Adds borders to both the completion popup and documentation popup.

------------------------------------------------------------------------

Key mappings:

-- Key --	------- Action -------
<C-b>		scroll docs up
<C-f>		scroll docs down
<C-Space>	open completion
<C-e>		close completion
<CR>		confirm selected item

------------------------------------------------------------------------

Completion sources

	sources = cmp.config.sources({
	  { name = "nvim_lsp" },
	  { name = "luasnip" },
	}, {
	  { name = "buffer" },
	})

The first group has higher priority:

  * LSP suggestions
  * snippets

The second group is lower priority:

  * buffer words


#########################################################################################################


~/.config/nvim/lua/plugins/debugging.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

Core plugin

	"mfussenegger/nvim-dap"

This is the main Debug Adapter Protocol engine. It lets Neovim communicate with debug adapters such as debugpy for Python and delve for Go.

------------------------------------------------------------------------

Dependencies

	"rcarriga/nvim-dap-ui"
	"leoluz/nvim-dap-go"
	"mfussenegger/nvim-dap-python"
	"nvim-neotest/nvim-nio"

These extend the debugging setup:

--- Plugin ---		-------- Purpose --------
nvim-dap-ui		visual debugging panels
nvim-dap-go		Go debugging integration
nvim-dap-python		Python/debugpy integration
nvim-nio		async dependency for dap-ui

------------------------------------------------------------------------

Module loading

	local dap = require("dap")
	local dapui = require("dapui")
	local dap_python = require("dap-python")

This imports the modules we use later in the config.

------------------------------------------------------------------------

UI setup

	dapui.setup()

Initializes the DAP UI layout.

This gives us windows for things like:

  * variables
  * scopes
  * watches
  * call stack
  * breakpoints
  * REPL

------------------------------------------------------------------------

Go setup

	require("dap-go").setup()

Configures Go debugging through Delve.

Since we already installed go and delve, this should work properly.

------------------------------------------------------------------------

Python setup

	dap_python.setup("python3")

Configures Python debugging through debugpy.

The "python3" argument tells nvim-dap-python which Python executable to use.

------------------------------------------------------------------------

Pytest runner

	dap_python.test_runner = "pytest"

Tells nvim-dap-python to use pytest for Python test debugging.

------------------------------------------------------------------------

Auto-open DAP UI

	dap.listeners.before.attach.dapui_config = function()
	  dapui.open()
	end

This opens the debugging UI before attaching to an existing process.


	dap.listeners.before.launch.dapui_config = function()
	  dapui.open()
	end

This opens the debugging UI before launching a new debug session.

------------------------------------------------------------------------

Auto-close DAP UI

	dap.listeners.before.event_terminated.dapui_config = function()
	  dapui.close()
	end

Closes the UI when the debug session terminates.


	dap.listeners.before.event_exited.dapui_config = function()
	  dapui.close()
	end

Closes the UI when the debugged program exits.

------------------------------------------------------------------------

Keymaps

	<Leader>dt

Toggles a breakpoint on the current line.


	<Leader>dc

Starts or continues a debug session.


#########################################################################################################


~/.config/nvim/lua/plugins/git-integration.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

gitsigns.nvim

	"lewis6991/gitsigns.nvim"

This plugin adds Git-aware signs inside the editor gutter. It shows which lines were added, changed, or deleted compared to Git.

------------------------------------------------------------------------

Gitsigns setup

	require("gitsigns").setup()

Initializes Gitsigns using the default configuration.

------------------------------------------------------------------------

Preview hunk keymap

	<leader>gp

Runs:

	:Gitsigns preview_hunk

This opens a small preview showing what changed in the current Git hunk.

------------------------------------------------------------------------

Toggle line blame keymap

	<leader>gt

Runs:

	:Gitsigns toggle_current_line_blame

This toggles inline blame text for the current line, showing commit information.

------------------------------------------------------------------------

vim-fugitive

	"tpope/vim-fugitive"

This adds full Git command integration inside Neovim.

It gives us commands like:

	:Git (or just ":G", which is a shorthand for ":Git")
	:Git add (e.g. :Git add . or :G add .)
	:Git commit
	:Git push
	:Git status
	:Git blame
	:Gdiffsplit
	:Gwrite
	:Gread
	

IMPORTANT DISTINCTION:

The ":G" shorthand applies only to Git subcommands passed through Fugitive and NOT to Fugitive's own standalone commands.

For example:

  * ":Git status" is equivalent to ":G status"
  * ":Git push" is equivalent to ":G push"
  * ":Git blame" is equivalent to ":G blame"

These are Git subcommands passed through Fugitive.

However, the same does not apply to the following examples:

  * :Gdiffsplit
  * :Gread
  * :Gwrite

These are dedicated Fugitive commands themselves.


#########################################################################################################


~/.config/nvim/lua/plugins/lsp-config.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Mason

mason.nvim installs external tools used by Neovim, including LSP servers, linters, formatters, and debuggers. The custom icons configure how Mason displays package states.

---------------------------------------------------------------------------------------------------------

2. mason-lspconfig

mason-lspconfig.nvim connects Mason with nvim-lspconfig. The ensure_installed list tells Mason to automatically install all listed LSP servers, such as lua_ls, pyright, clangd, rust_analyzer, yamlls, and others.

---------------------------------------------------------------------------------------------------------

3. nvim-lspconfig

nvim-lspconfig provides the server configurations used by Neovim’s built-in LSP client.

---------------------------------------------------------------------------------------------------------

4. Completion capabilities

	local capabilities =
	  require("cmp_nvim_lsp").default_capabilities()

This integrates LSP completion with nvim-cmp, giving better completion behavior across all configured language servers.

---------------------------------------------------------------------------------------------------------

5. Server list

The servers table keeps all LSP server names in one place. This avoids repeating the same setup code many times.

---------------------------------------------------------------------------------------------------------

6. LuaLS special case

lua_ls needs special handling because Neovim exposes vim as a global variable, but standard Lua does not know about it.

This section fixes warnings like:

	Undefined global 'vim'

by adding:

	globals = { "vim" }

---------------------------------------------------------------------------------------------------------

7. Generic server setup

Every server except lua_ls receives the shared completion capabilities through:

	vim.lsp.config(server, {
	  capabilities = capabilities,
	})

---------------------------------------------------------------------------------------------------------

8. Enabling servers

	vim.lsp.enable(servers)

Starts/enables all configured LSP servers using the newer Neovim LSP workflow.

---------------------------------------------------------------------------------------------------------

9. LspAttach keymaps

The LspAttach autocmd creates keymaps only when an LSP is actually attached to the current buffer.

The mappings are:

-- Key --	----- Action -----
H		hover documentation
<leader>gd	go to definition
<leader>gr	show references
<leader>ca	code actions


#########################################################################################################


~/.config/nvim/lua/plugins/lualine.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Plugin declaration

	"nvim-lualine/lualine.nvim"

This installs lualine.nvim, a configurable statusline plugin for Neovim.

---------------------------------------------------------------------------------------------------------

2. Dependency

	"nvim-tree/nvim-web-devicons"

This provides icons for filetypes, Git status, diagnostics, and other UI components.

---------------------------------------------------------------------------------------------------------

3. Setup function

	require("lualine").setup({...})

Initializes and configures lualine.

---------------------------------------------------------------------------------------------------------

4. Icons

	icons_enabled = true

Allows lualine to display icons.

---------------------------------------------------------------------------------------------------------

5. Theme

	theme = "dracula"

Uses the Dracula color palette for the statusline.

---------------------------------------------------------------------------------------------------------

6. Component separators

	component_separators = {
	  left = "",
	  right = "",
	}

These separate smaller items inside the same lualine section.

---------------------------------------------------------------------------------------------------------

7. Section separators

	section_separators = {
	  left = "",
	  right = "",
	}

These separate larger sections and create the Powerline-style look.


#########################################################################################################


~/.config/nvim/lua/plugins/neo-tree.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Plugin declaration

	"nvim-neo-tree/neo-tree.nvim"

Installs Neo-tree, a file explorer/tree plugin for Neovim.

---------------------------------------------------------------------------------------------------------

2. Branch

	branch = "v3.x"

Uses the stable v3.x branch of Neo-tree.

---------------------------------------------------------------------------------------------------------

3. Dependencies

Neo-tree needs:

	"nvim-lua/plenary.nvim"
	"MunifTanjim/nui.nvim"
	"nvim-tree/nvim-web-devicons"

These provide utility functions, UI components, and icons.

---------------------------------------------------------------------------------------------------------

4. Loading behavior

	lazy = false

Loads Neo-tree immediately instead of lazy-loading it later.

---------------------------------------------------------------------------------------------------------

5. Filesystem filtering

	filtered_items = {
	  visible = true,
	  hide_dotfiles = false,
	  hide_gitignored = true,
	}

This means:

------- Setting -------		-------------- Effect --------------
visible = true			filtered items can be shown/toggled
hide_dotfiles = false		dotfiles are visible       
hide_gitignored = true		Git-ignored files stay hidden

---------------------------------------------------------------------------------------------------------

6. Keymap

	<C-n>

Runs:

	:Neotree filesystem reveal left

That opens Neo-tree:

  * using the filesystem source
  * on the left side
  * revealing the current file


#########################################################################################################


~/.config/nvim/lua/plugins/none-ls.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. mason-null-ls.nvim

	"jay-babu/mason-null-ls.nvim"

Connects:

  * Mason
  * none-ls

so Mason can automatically install formatter/linter tools used by none-ls.

---------------------------------------------------------------------------------------------------------

2. Dependencies

	dependencies = {
	  "mason-org/mason.nvim",
	  "nvimtools/none-ls.nvim",
	}

Requires:

  * Mason package manager
  * none-ls core plugin

---------------------------------------------------------------------------------------------------------

3. ensure_installed

	ensure_installed = {
	  ...
	}

Tells Mason to install these external tools automatically.

---------------------------------------------------------------------------------------------------------

4. Installed tools

- Tool -	---------- Purpose ----------
stylua		Lua formatter
prettier	JS/TS/HTML/CSS/JSON formatter
black		Python formatter
isort		Python import sorter
rubocop		Ruby formatter/linter
erb-lint	ERB linter

---------------------------------------------------------------------------------------------------------

5. Automatic installation

	automatic_installation = true

If a configured tool is missing Mason installs it automatically.

---------------------------------------------------------------------------------------------------------

6. none-ls.nvim

	"nvimtools/none-ls.nvim"

none-ls integrates:

  * external formatters
  * linters
  * diagnostics tools

into Neovim’s built-in LSP framework.

So they behave like native LSP features.

---------------------------------------------------------------------------------------------------------

7. require("null-ls")

	local null_ls = require("null-ls")

Even though the plugin is now called:

	none-ls

the Lua module name remains:

	"null-ls"

for backward compatibility.

---------------------------------------------------------------------------------------------------------

8. Formatting sources

	null_ls.builtins.formatting.*

Registers formatters with Neovim’s LSP formatting system.

Examples:

  * stylua
  * black
  * prettier

---------------------------------------------------------------------------------------------------------

9. Diagnostic sources

	null_ls.builtins.diagnostics.*

Registers linting/diagnostic tools.

Examples:

  * Rubocop diagnostics
  * ERB lint diagnostics

---------------------------------------------------------------------------------------------------------

10. on_attach

	on_attach = function(_client, bufnr)

Runs whenever none-ls attaches to a buffer.

This is the ideal place for:

  * formatting keymaps
  * formatting-specific behavior

---------------------------------------------------------------------------------------------------------

11. Formatting keymap

	<leader>gf

Runs:

	vim.lsp.buf.format()

This triggers formatting through Neovim’s LSP formatting system.

Because none-ls registers formatters as LSP sources, they work seamlessly through the standard LSP API.

---------------------------------------------------------------------------------------------------------

12. Buffer-local keymap

	buffer = bufnr

Restricts the formatting mapping to buffers where none-ls is attached.


#########################################################################################################


~/.config/nvim/lua/plugins/oil.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Plugin declaration

	"stevearc/oil.nvim"

This installs Oil, a file explorer that treats directories like editable buffers.

---------------------------------------------------------------------------------------------------------

2. Dependency

	"nvim-tree/nvim-web-devicons"

Provides icons for files and folders.

---------------------------------------------------------------------------------------------------------

3. Loading behavior

	lazy = false

Loads Oil immediately on startup.

---------------------------------------------------------------------------------------------------------

4. Module loading

	local oil = require("oil")

Imports the Oil Lua module so we can configure and use it.

---------------------------------------------------------------------------------------------------------

5. Hidden files

	show_hidden = true

Hidden files are shown by default, including dotfiles like .gitignore, .env, and .config.

---------------------------------------------------------------------------------------------------------

6. Keymap

	<leader>-

Runs:

	oil.toggle_float

This opens or closes Oil in a floating window.


#########################################################################################################


~/.config/nvim/lua/plugins/telescope.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Telescope plugin

	"nvim-telescope/telescope.nvim"

This installs Telescope, Neovim’s modern fuzzy finder/search framework.

Telescope can search:

  * files
  * text content
  * buffers
  * help pages
  * Git data
  * LSP symbols
  * diagnostics
  * and more.

---------------------------------------------------------------------------------------------------------

2. Version

	version = "*"

Uses the latest stable release.

---------------------------------------------------------------------------------------------------------

3. plenary.nvim

	"nvim-lua/plenary.nvim"

Provides utility Lua functions required by Telescope.

Many Neovim plugins depend on Plenary.

---------------------------------------------------------------------------------------------------------

4. telescope-fzf-native.nvim

	"nvim-telescope/telescope-fzf-native.nvim"

Adds a native compiled FZF sorter.

Benefits:

  * faster searching
  * better fuzzy matching
  * improved Telescope performance

---------------------------------------------------------------------------------------------------------

5. build = "make"

	build = "make"

Compiles the native extension during installation.

Requires:

  * make
  * compiler toolchain

installed on the system.

---------------------------------------------------------------------------------------------------------

6. telescope-ui-select.nvim

	"nvim-telescope/telescope-ui-select.nvim"

Replaces some built-in Vim selection UIs with Telescope dropdowns.

This improves:

  * code action selection
  * plugin selection menus
  * generic vim.ui.select() interfaces

---------------------------------------------------------------------------------------------------------

7. Loading Telescope modules

	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

  * telescope = core configuration API
  * builtin = built-in Telescope pickers/functions

---------------------------------------------------------------------------------------------------------

8. Telescope setup

	telescope.setup({...})

Main Telescope configuration function.

---------------------------------------------------------------------------------------------------------

9. ui-select dropdown theme

	require("telescope.themes").get_dropdown({})

Uses Telescope’s dropdown-style UI for:

  * selections
  * code actions
  * UI menus

instead of the default larger layout.

---------------------------------------------------------------------------------------------------------

10. Loading extensions

	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")

Activates the configured Telescope extensions.

Without this extensions are installed but not enabled.

---------------------------------------------------------------------------------------------------------

11. File finder keymap

	<leader>ff

Runs:

	builtin.find_files

Opens Telescope file search.

---------------------------------------------------------------------------------------------------------

12. Live grep keymap

	<leader>fg

Runs:

	builtin.live_grep

Searches text across files using ripgrep.

Requires "ripgrep" installed on the system.


#########################################################################################################


~/.config/nvim/lua/plugins/treesitter.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Plugin declaration

	"nvim-treesitter/nvim-treesitter"

This installs the Treesitter integration plugin.

Treesitter gives Neovim syntax-aware parsing for languages.

---------------------------------------------------------------------------------------------------------

2. Branch

	branch = "main"

We are using the newer main branch, which follows the newer Neovim 0.12-style Treesitter architecture.

This is why our config uses:

	require("nvim-treesitter").setup()
	require("nvim-treesitter").install()
	vim.treesitter.start()

instead of the older:

	require("nvim-treesitter.configs").setup()

---------------------------------------------------------------------------------------------------------

3. Loading behavior

	lazy = false

Loads Treesitter immediately when Neovim starts.

---------------------------------------------------------------------------------------------------------

4. Build command

	build = ":TSUpdate"

Runs :TSUpdate after plugin installation/update, updating installed parsers.

---------------------------------------------------------------------------------------------------------

5. Setup

	require("nvim-treesitter").setup({
	  install_dir = vim.fn.stdpath("data") .. "/site",
	})

Configures where Treesitter parsers are installed.

---------------------------------------------------------------------------------------------------------

6. Parser installation

	require("nvim-treesitter").install({
	  ...
	})

Installs parsers for our selected languages.

These parsers power syntax-aware highlighting, folding, injections, and structural features.

---------------------------------------------------------------------------------------------------------

7. FileType autocmd

	vim.api.nvim_create_autocmd("FileType", {

Runs whenever Neovim detects a filetype.

Examples:

main.py      → python
init.lua     → lua
main.rs      → rust
index.html   → html

---------------------------------------------------------------------------------------------------------

8. Starting Treesitter

	pcall(vim.treesitter.start, args.buf)

Starts Treesitter for the current buffer.

pcall is useful because it avoids errors if:

  * a parser is missing
  * a filetype is unsupported
  * Treesitter cannot start for that buffer

---------------------------------------------------------------------------------------------------------

9. Folding

	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo[0][0].foldmethod = "expr"

Enables Treesitter-based folding in the current window.

Because we also added this in lazy.lua:

	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99

files should open unfolded, but we can still manually use folding commands like:

	zc  close fold
	zo  open fold
	za  toggle fold
	zM  close all folds
	zR  open all folds


#########################################################################################################


~/.config/nvim/plugin/floaterminal.lua


Segment-by-segment analysis

---------------------------------------------------------------------------------------------------------

1. Terminal escape keymap

	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", ...)

This maps double Escape in terminal mode to exit terminal insert mode and return to normal mode. This is useful because terminal buffers otherwise capture most keys as shell input.

---------------------------------------------------------------------------------------------------------

2. Custom highlight groups

	FloaterminalNormal
	FloaterminalBorder

These define custom highlight groups for the floating terminal and its border. bg = "NONE" helps the terminal visually blend with our current Neovim/terminal background.

---------------------------------------------------------------------------------------------------------

3. State table

	local state = {
	  floating = {
	    buf = -1,
	    win = -1,
	    job = -1,
	  },
	}

This stores the current terminal buffer, floating window, and shell job. Using -1 means “not currently valid/created.”

---------------------------------------------------------------------------------------------------------

4. Floating window creation

	create_floating_window(opts)

This function creates a centered floating window using 80% of the current editor width and height.

It also reuses an existing buffer if one is valid, otherwise it creates a new scratch buffer.

---------------------------------------------------------------------------------------------------------

5. Window layout

	relative = "editor"
	style = "minimal"
	border = "rounded"

This creates a centered floating window relative to the whole editor, with minimal UI and a rounded border.

---------------------------------------------------------------------------------------------------------

6. Window styling

	vim.wo[win].winblend = 0
	vim.wo[win].winhighlight = ...

winblend = 0 disables transparency. winhighlight applies our custom highlight groups specifically to this floating window.

---------------------------------------------------------------------------------------------------------

7. Reset function

	reset_terminal()

This hides the window, deletes the terminal buffer, and resets the stored state.

This is important because when the shell exits, we do not want to keep a dead terminal buffer around.

---------------------------------------------------------------------------------------------------------

8. Toggle function

	toggle_terminal()

This is the main function.

If the terminal is not visible, it creates a floating window and starts a shell. If it is already visible, it hides the window.

---------------------------------------------------------------------------------------------------------

9. Starting the shell

	vim.fn.jobstart(vim.o.shell, {
	  term = true,
	  on_exit = function()
	    vim.schedule(reset_terminal)
	  end,
	})

This starts our default shell inside the buffer as a terminal job.

The on_exit callback safely resets the floating terminal after typing exit or pressing <C-d>, preventing a blank floating window issue.

---------------------------------------------------------------------------------------------------------

10. Automatic insert mode

	vim.cmd.startinsert()

This immediately enters terminal insert mode when the floating terminal opens, so we can start typing shell commands right away.

---------------------------------------------------------------------------------------------------------

11. User command

	vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

Creates the :Floaterminal command to toggle the terminal.

---------------------------------------------------------------------------------------------------------

12. Keymap

	<Space>tt

Toggles the floating terminal in both normal and terminal mode.

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

-------------------------------------- Neovim Workflow Cheatsheet ---------------------------------------

FILES / NAVIGATION
----------------------------------------------------------------------------
<leader>-	Opens or closes Oil in a floating window
<leader>ff	Opens Telescope file search
<leader>fg	Searches text across files using ripgrep
<C-n>		Opens Neo-tree file explorer

----------------------------------------------------------------------------

LSP / CODE INTELLIGENCE
----------------------------------------------------------------------------
H		Hover documentation
<leader>gd	Go to definition
<leader>gr	Show references
<leader>ca	Code actions
<leader>gf	Format current buffer

----------------------------------------------------------------------------

GIT
----------------------------------------------------------------------------
<leader>gp	Preview hunk
<leader>gt	Toggle line blame

----------------------------------------------------------------------------

DEBUGGING (DAP)
----------------------------------------------------------------------------
<leader>dt	Toggles a breakpoint on the current line.
<leader>dc	Starts or continues a debug session.

----------------------------------------------------------------------------

TERMINAL
----------------------------------------------------------------------------
<Space>tt	Toggles the floating terminal in both normal and terminal mode


########################################### README ENDS HERE ############################################
