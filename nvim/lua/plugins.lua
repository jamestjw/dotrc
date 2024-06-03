local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- Toggle file tree
map("n", "tr", ":NvimTreeToggle<CR>")

-- FZF
map("n", "ff", ":FZF<CR>") -- Search for file
map("n", "fw", ":Rg<CR>")  -- Search for word


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
        "luvit-meta/library", -- see below
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
    }
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
    end
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
      require("nvim-tree").setup {}
    end,
  },

  {
    "junegunn/fzf.vim",
     dependencies = { "junegunn/fzf" },
     config = function(self, plugin)
       vim.opt.rtp:append("/usr/local/opt/fzf")
     end
  },

  -- Bar at the bottom
  "vim-airline/vim-airline",

  -- Configurations for Nvim LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPost" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  -- Autocomplete parentheses
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = function ()
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
    "preservim/nerdcommenter",
    config = function(plugin)
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCommentEmptyLines = 1
    end
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
    end
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
}
