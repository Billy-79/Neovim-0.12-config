-- In terminal mode, pressing Esc twice exits terminal insert mode
-- and returns to normal mode.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Highlight group for the floating terminal background.
--
-- `bg = "NONE"` allows the terminal/editor background to show through.
vim.api.nvim_set_hl(0, "FloaterminalNormal", { bg = "NONE" })

-- Highlight group for the floating terminal border.
vim.api.nvim_set_hl(0, "FloaterminalBorder", { bg = "NONE" })

-- Store the current floating terminal state.
--
-- `buf` = terminal buffer ID
-- `win` = floating window ID
-- `job` = terminal shell job ID
local state = {
  floating = {
    buf = -1,
    win = -1,
    job = -1,
  },
}

-- Create a centered floating window.
local function create_floating_window(opts)
  opts = opts or {}

  -- Default width/height: 80% of the current editor size.
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate position so the floating window appears centered.
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Reuse an existing valid buffer if provided.
  -- Otherwise create a new scratch buffer.
  local buf
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Open the floating window.
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- Disable transparency/blending for the floating window.
  vim.wo[win].winblend = 0

  -- Apply custom highlight groups to the floating window.
  vim.wo[win].winhighlight =
    "Normal:FloaterminalNormal,FloatBorder:FloaterminalBorder"

  -- Return the buffer and window IDs.
  return { buf = buf, win = win }
end

-- Fully reset the floating terminal.
--
-- This runs when the terminal shell exits.
local function reset_terminal()
  -- Hide the floating window if it still exists.
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
  end

  -- Delete the terminal buffer if it still exists.
  if vim.api.nvim_buf_is_valid(state.floating.buf) then
    vim.api.nvim_buf_delete(state.floating.buf, { force = true })
  end

  -- Reset stored state so the next toggle creates a fresh terminal.
  state.floating = {
    buf = -1,
    win = -1,
    job = -1,
  }
end

-- Toggle the floating terminal open/closed.
local function toggle_terminal()
  -- If the floating window does not exist, create/open it.
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    local floating = create_floating_window({ buf = state.floating.buf })

    -- Store the newly created/reused buffer and window.
    state.floating.buf = floating.buf
    state.floating.win = floating.win

    -- If this buffer is not already a terminal, start a shell inside it.
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      state.floating.job = vim.fn.jobstart(vim.o.shell, {
        -- Run the job as a terminal.
        term = true,

        -- When the shell exits, reset the floating terminal safely.
        on_exit = function()
          vim.schedule(reset_terminal)
        end,
      })
    end

    -- Enter terminal insert mode automatically.
    vim.cmd.startinsert()
  else
    -- If the terminal is already visible, hide the floating window.
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create a user command:
--   :Floaterminal
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Toggle the floating terminal with Space + tt.
vim.keymap.set(
  { "n", "t" },
  "<Space>tt",
  toggle_terminal,
  { desc = "Toggle floating terminal" }
)
