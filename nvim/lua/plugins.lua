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

  {
    "ibhagwan/fzf-lua",
    -- Optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "ff",
        -- <C-g> disables `.gitignore`
        ":Files<CR>",
        -- ":Files<CR><C-g>"
        desc = "[F]ind [F]iles",
      },
      {
        "fw",
        ":RG<CR><C-g>",
        desc = "[F]ind [w]ord",
      },
      {
        "fb",
        ":Buffers<CR>",
        desc = "[F]ind [b]uffers",
      },
      {
        "fh",
        ":Helptags<CR>",
        desc = "[F]ind [h]elptags",
      },
      {
        "ft",
        ":BTags<CR>",
        desc = "[F]ind [t]ags",
      },
      {
        "fl",
        ":FzfLua grep_last<CR>",
        desc = "[F]ind [l]ast",
      },
      {
        "fu",
        ":FzfLua grep_cword<CR>",
        mode = { "n" },
        desc = "[F]ind [u]nder",
      },
      {
        "fu",
        ":FzfLua grep_visual<CR>",
        mode = { "v" },
        desc = "[F]ind [u]nder",
      },
    },
    opts = function()
      local actions = require("fzf-lua.actions")
      -- calling `setup` is optional for customization
      return {
        "fzf-vim",
        grep = {
          actions = {
            ["ctrl-r"] = { actions.toggle_ignore },
          },
        },
      }
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
  --{
  --  "isovector/cornelis",
  --  ft = { "agda" },
  --  build = "stack build",
  --  dependencies = {
  --    "kana/vim-textobj-user",
  --    "neovimhaskell/nvim-hs.vim",
  --  },
  --  init = function()
  --    require("config.cornelis")
  --  end,
  --},

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
        desc = "[b]lame [w]iles",
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

  {
    "lervag/vimtex",
    ft = "tex", -- Only load on lua files
    -- uncomment to pin to a specific release
    -- tag = "v2.15",
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
      -- You also will likely want nvim-cmp or some completion engine
    },

    -- See details below for full configuration options
    opts = function()
      local default_opts = {
        mappings = true,
      }
      local status, lspconfig = pcall(require, "lspconfig")
      if not status then
        print("Failed to import lspconfig!")
      else
        default_opts.lsp = {
          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          on_attach = lspconfig.util.default_config.on_attach,
        }
      end

      return default_opts
    end,
  },
}
