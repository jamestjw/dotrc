local cmd = vim.cmd
local api = vim.api

-- Relative line number
vim.opt.relativenumber = true

-- Tab widths
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Display diagnostics (Don't need this since I'm using `trouble` now)
-- vim.keymap.set('n', "<leader>dd", vim.diagnostic.open_float, bufopts)

vim.o.formatoptions = "tcqjr"

cmd([[syntax on]])
cmd([[filetype plugin indent on]])

-- BQN stuff
cmd([[au! BufRead,BufNewFile *.bqn setf bqn]])
cmd([[au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("detect_vial_config", { clear = true }),
  desc = "Set filetype for Vial config files",
  pattern = { "*.vil" },
  callback = function()
    vim.cmd("set filetype=json")
  end,
})

-- Shifting using '<' and '>' maintains visual mode selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Quit :terminal mode using <Esc>
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Window resizing:
-- Make the window taller
vim.keymap.set("n", "<C-t>", "<C-w>+")
-- Make the window shorter
vim.keymap.set("n", "<C-s>", "<C-w>-")
-- Shift window to the left
vim.keymap.set("n", "<C-,>", "<C-w><lt>")
-- Shift window to the right
vim.keymap.set("n", "<C-.>", "<C-w>>")

-- Shortcut for tab navigation
-- Usage: <leader>1 to switch to tab 1 and so on
for i = 1, 9 do
  local key = string.format("<leader>%d", i)
  local command = string.format(":tabn %d<CR>", i)
  local desc = string.format("Navigate to tab %d", i)
  vim.keymap.set("n", key, command, { silent = true, noremap = true, desc = desc })
end

-- Terminal mode configuration
-- start in insert mode
api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
-- remove line numbers
api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonumber norelativenumber" })
-- no sign column
api.nvim_create_autocmd("TermEnter", { pattern = "*", command = "setlocal signcolumn=no" })

-- Start a terminal in a split screen
vim.keymap.set("n", "<leader>ct", function()
  vim.cmd.vnew()
  vim.cmd.wincmd("J")
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 10)
  -- Alternatively: api.nvim_command("below split | resize 10 | term")
end)

-- Make it easier to source stuff
-- source the entire file we have open
vim.keymap.set("n", "<space><space>s", "<cmd>source %<CR>")
-- source current line
vim.keymap.set("n", "<space>s", ":.lua<CR>")
-- source visual selection
vim.keymap.set("v", "<space>s", ":lua<CR>")
