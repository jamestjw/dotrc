local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- Toggle file tree
map("n", "tr", ":NvimTreeToggle<CR>")

----------------------------------
-- PLUGINS -----------------------
----------------------------------

return {
	{ "folke/lazy.nvim", version = false },

	-- Autocomplete for neovim config files
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Library items can be absolute paths
				-- "~/projects/my-awesome-lib",
				-- Or relative, which means they will be resolved as a plugin
				-- "LazyVim",
				-- When relative, you can also provide a path to the library in the plugin dir

				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{ "folke/neoconf.nvim", cmd = "Neoconf" },

	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}
			metals_config.on_attach = function(client, bufnr)
				-- your on_attach function
			end
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},

	-- File tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},

	{ "junegunn/fzf", build = "./install --bin" },

	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local actions = require("fzf-lua.actions")
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				"fzf-vim",
				grep = {
					actions = {
						["ctrl-r"] = { actions.toggle_ignore },
					},
				},
			})

			-- Search for file
			-- ctrl+g disables `.gitignore`
			map("n", "ff", ":Files<CR>")
			-- map("n", "ff", ":Files<CR><C-g>")

			-- Search for word
			-- ctrl+g enables fuzzy search
			map("n", "fw", ":RG<CR><C-g>")

			-- Search for buffer
			map("n", "fb", ":Buffers<CR>")

			-- Search helptags
			map("n", "fh", ":Helptags<CR>")
		end,
	},

	-- Bar at the bottom
	"vim-airline/vim-airline",

	-- Configurations for Nvim LSP
	{
		"neovim/nvim-lspconfig",
		-- event = { "BufNewFile", "BufReadPost" },
	},

	-- Autocomplete parentheses
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = function()
			require("config.autopairs").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function()
			require("config.cmp")
		end,
	},

	{
		"folke/trouble.nvim",
		keys = require("config.trouble").keys,
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},

	-- Use treesitter to tell which kind of code we dealing with under the cursor
	-- Useful in filetypes like `vue` where there is HTML and JS
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	-- Idris
	{
		"idris-hackers/idris-vim",
		ft = { "idris" },
	},

	-- BQN stuff
	{
		"mlochbaum/BQN",
		ft = { "bqn" },
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/editors/vim")
		end,
	},
	{
		"https://git.sr.ht/~detegr/nvim-bqn",
		ft = { "bqn" },
	},

	-- Agda mode
	{
		"isovector/cornelis",
		ft = { "agda" },
		build = "stack build",
		dependencies = {
			"kana/vim-textobj-user",
			"neovimhaskell/nvim-hs.vim",
		},
		init = function()
			require("config.cornelis")
		end,
	},

	-- Surround
	"tpope/vim-surround",

	-- Display Git blame
	{
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup()

			map("n", "<leader>bw", ":BlameToggle window<CR>")
			map("n", "<leader>bv", ":BlameToggle virtual<CR>")
		end,
	},

	-- Soft and hard wrapping
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup({})
		end,
	},

	{
		"lervag/vimtex",
		ft = "tex", -- only load on lua files
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
		end,
	},

	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			-- you also will likely want nvim-cmp or some completion engine
		},

		-- see details below for full configuration options
		opts = {
			lsp = {
				-- Use an on_attach function to only map the following keys
				-- after the language server attaches to the current buffer
				on_attach = function(_, buffer)
					-- Mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local bufopts = { noremap = true, silent = true, buffer = buffer }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, bufopts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				end,
			},
			mappings = true,
		},
	},
}
