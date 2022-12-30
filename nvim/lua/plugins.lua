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
end)

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- LSP mappings
map("n", "gD", function()
  vim.lsp.buf.definition()
end)

map("n", "K", function()
  vim.lsp.buf.hover()
end)

map("n", "gi", function()
  vim.lsp.buf.implementation()
end)

map("n", "gr", function()
  vim.lsp.buf.references()
end)

-- map("n", "gds", function()
--   vim.lsp.buf.document_symbol()
-- end)

map("n", "gws", function()
  vim.lsp.buf.workspace_symbol()
end)

map("n", "<leader>cl", function()
  vim.lsp.codelens.run()
end)

map("n", "<leader>sh", function()
  vim.lsp.buf.signature_help()
end)

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end)

map("n", "<leader>f", function()
  vim.lsp.buf.formatting()
end)

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end)

map("n", "<leader>ws", function()
  require("metals").hover_worksheet()
end)

-- all workspace diagnostics
map("n", "<leader>aa", function()
  vim.diagnostic.setqflist()
end)

-- all workspace errors
map("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", function()
  vim.diagnostic.setloclist()
end)

map("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", function()
  require("dap").continue()
end)

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)

map("n", "<leader>dK", function()
  require("dap.ui.widgets").hover()
end)

map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<leader>dso", function()
  require("dap").step_over()
end)

map("n", "<leader>dsi", function()
  require("dap").step_into()
end)

map("n", "<leader>dl", function()
  require("dap").run_last()
end)

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Toggle NERDTree
map("n", "tr", ":NERDTreeToggle<CR>")

-- FZF
map("n", "ff", ":FZF<CR>")
map("n", "fw", ":Rg<CR>")

-- Enable color theme
cmd([[ colorscheme onedark ]])

-- Enable line number
cmd([[ set number ]])

-- Lsp config
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

lspconfig.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.racket_langserver.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
-- LSP config END

-- Tab width for Scheme
cmd [[autocmd FileType scheme setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2]]

