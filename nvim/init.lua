local cmd = vim.cmd
local opt = vim.opt

-- disable netrw since we are using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('plugins') -- lua/plugins.lua
require('lspstuff') -- lua/lspstuff.lua

-- Relative line number
vim.wo.relativenumber = true

-- Tab widths
cmd [[set autoindent expandtab tabstop=2 shiftwidth=2]] -- Global
cmd [[autocmd FileType scheme setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2]]
cmd [[autocmd FileType ocaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2]]

-- Display diagnostics (Don't need this since I'm using `trouble` now)
-- vim.keymap.set('n', "<leader>dd", vim.diagnostic.open_float, bufopts)

cmd [[syntax on]]
cmd [[filetype on]]
cmd [[filetype plugin indent on]]

-- BQN stuff
cmd [[au! BufRead,BufNewFile *.bqn setf bqn]]
cmd [[au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif]]

-- make < > shifts keep selection
cmd [[ vnoremap < <gv ]]
cmd [[ vnoremap > >gv ]]

-- Ocaml indent
-- TODO: Does this actually work?
opt.rtp:append("/Users/jamestjw/.opam/default/share/ocp-indent/vim")

-- Install lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
