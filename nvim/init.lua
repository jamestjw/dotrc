-- Remap leader keys
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw since we are using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "kanagawa" } },
  -- Automatically check for plugin updates
  checker = { enabled = false },
})

require("lspstuff") -- lua/lspstuff.lua
require("misc") -- lua/misc.lua
