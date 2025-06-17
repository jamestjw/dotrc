----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

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

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    keys = {
      {
        "tr",
        ":NvimTreeToggle<CR>",
        desc = "Toggle [tr]ee",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  { "junegunn/fzf", build = "./install --bin" },

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
    config = function()
      require("config.autopairs").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require("config.cmp")
    end,
  },

  {
    "folke/trouble.nvim",
    keys = require("config.trouble").keys,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },

  -- Idris
  {
    "idris-hackers/idris-vim",
    ft = { "idris" },
  },

  -- Surround
  "tpope/vim-surround",

  -- Display Git blame
  {
    "FabijanZulj/blame.nvim",
    opts = {},
    keys = {
      {
        "<leader>bw",
        ":BlameToggle window<CR>",
        desc = "[b]lame [w]indow",
      },
      {
        "<leader>bv",
        ":BlameToggle virtual<CR>",
        desc = "[b]lame [v]irtual",
      },
    },
  },

  -- Soft and hard wrapping
  {
    "andrewferrier/wrapping.nvim",
    opts = {
      notify_on_switch = false,
    },
  },
}
