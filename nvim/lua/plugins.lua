local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set

----------------------------------
-- PLUGINS -----------------------
----------------------------------
cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  -- Scala
  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("config.metals")
    end
  })

  use({ "preservim/nerdtree" })

  vim.opt.runtimepath:append(',/usr/local/opt/fzf')
  use({ "junegunn/fzf" })
  use({ "junegunn/fzf.vim" })

  -- Color theme
  use({ "joshdick/onedark.vim" })

  -- Bar at the bottom
  use({ "vim-airline/vim-airline" })

  -- Configurations for Nvim LSP
  use 'neovim/nvim-lspconfig'

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}

  -- Autocomplete parentheses
  -- use 'tmsvg/pear-tree'
  use {
    "windwp/nvim-autopairs",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("config.autopairs").setup()
    end,
  }

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
    config = function()
      require("config.cmp")
    end
  })

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.trouble")
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Comments
  use { "preservim/nerdcommenter"}

  -- Idris
  use { "idris-hackers/idris-vim" }
end)

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
