-- Treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
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
        "typescript",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "sql",
        "regex",
        "python",
        "vue",
        "clojure",
        "zig",
        -- Elixir and its templating language
        "elixir",
        "heex",
        "gleam",
        "cpp",
        "terraform",
        "rust",
      },
      endwise = {
        enable = true,
      },
    })
  end,
}
