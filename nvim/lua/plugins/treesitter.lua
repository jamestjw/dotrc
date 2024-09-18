-- Treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	opts = {
		autotag = {
			enable = true,
		},
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = {},
			},
			matchup = {
				enable = true,
				disable = {},
			},
			ensure_installed = {
				"markdown",
				"markdown_inline",
				"json",
				"yaml",
				"html",
				"javascript",
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"sql",
				"regex",
				"python",
				"vue",
				-- Elixir and its templating language
				"elixir",
				"heex",
			},
			endwise = {
				enable = true,
			},
		})
	end,
}
