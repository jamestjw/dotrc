local cmd = vim.cmd

require('plugins') -- lua/plugins.lua
require('lspstuff') -- lua/lspstuff.lua

-- Enable line number
cmd([[ set number ]])

-- Enable color theme
cmd([[ colorscheme onedark ]])

-- Tab width for Scheme
cmd [[autocmd FileType scheme setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2]]

-- Display diagnostics
vim.keymap.set('n', "<leader>dd", vim.diagnostic.open_float, bufopts)

cmd [[syntax on]]
cmd [[filetype on]]
cmd [[filetype plugin indent on]]

-- BQN stuff
cmd [[au! BufRead,BufNewFile *.bqn setf bqn]]
cmd [[au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif]]
