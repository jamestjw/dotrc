return {
  "vim-test/vim-test",
  keys = {
    { "<leader>t", ":TestNearest<CR>", silent = true },
    { "<leader>T", ":TestFile<CR>", silent = true },
    { "<leader>a", ":TestSuite<CR>", silent = true },
    { "<leader>lt", ":TestLast<CR>", silent = true },
    { "<leader>g", ":TestVisit<CR>", silent = true },
  },
}
