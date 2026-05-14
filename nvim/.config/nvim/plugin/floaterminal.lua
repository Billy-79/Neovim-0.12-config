vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_set_hl(0, "FloaterminalNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloaterminalBorder", { bg = "NONE" })

local state = {
  floating = {
    buf = -1,
    win = -1,
    job = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  vim.wo[win].winblend = 0
  vim.wo[win].winhighlight =
    "Normal:FloaterminalNormal,FloatBorder:FloaterminalBorder"

  return { buf = buf, win = win }
end

local function reset_terminal()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
  end

  if vim.api.nvim_buf_is_valid(state.floating.buf) then
    vim.api.nvim_buf_delete(state.floating.buf, { force = true })
  end

  state.floating = {
    buf = -1,
    win = -1,
    job = -1,
  }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    local floating = create_floating_window({ buf = state.floating.buf })

    state.floating.buf = floating.buf
    state.floating.win = floating.win

    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      state.floating.job = vim.fn.jobstart(vim.o.shell, {
        term = true,
        on_exit = function()
          vim.schedule(reset_terminal)
        end,
      })
    end

    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<Space>tt", toggle_terminal, { desc = "Toggle floating terminal" })
