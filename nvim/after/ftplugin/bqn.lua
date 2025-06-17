-- BQN stuff
vim.cmd([[au! BufRead,BufNewFile *.bqn setf bqn]])
vim.cmd([[au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif]])
