local map = vim.keymap.set

return {
	"vim-test/vim-test",
	config = function()
		map("n", "<leader>t", ":TestNearest<CR>", { silent = true })
		map("n", "<leader>T", ":TestFile<CR>", { silent = true })
		map("n", "<leader>a", ":TestSuite<CR>", { silent = true })
		map("n", "<leader>l", ":TestLast<CR>", { silent = true })
		map("n", "<leader>g", ":TestVisit<CR>", { silent = true })
	end,
}
