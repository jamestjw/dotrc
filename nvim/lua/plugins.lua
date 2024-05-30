local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- Toggle NERDTree
map("n", "tr", ":NERDTreeToggle<CR>")

-- FZF
map("n", "ff", ":FZF<CR>")
map("n", "fw", ":Rg<CR>")


----------------------------------
-- PLUGINS -----------------------
----------------------------------

return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = "catppuccin-mocha",
    }
  },

  "folke/neodev.nvim",

  "folke/which-key.nvim",

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

  "preservim/nerdtree",

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
  "neovim/nvim-lspconfig",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects",

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
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
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
  "idris-hackers/idris-vim",

  -- BQN stuff
  {
    "mlochbaum/BQN",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editors/vim")
    end
  },

  "https://git.sr.ht/~detegr/nvim-bqn",


  -- Agda mode
  "kana/vim-textobj-user", 
  "neovimhaskell/nvim-hs.vim",
  {
    "isovector/cornelis",
    build = "stack build",
    init = function()
      require("config.cornelis")
    end,
  },
  
  -- Surround
  "tpope/vim-surround",
}
