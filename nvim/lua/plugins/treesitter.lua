-- Treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    context_commentstring = {
      enable = true,
      config = {
        css = "// %s",
        typescript = { __default = "// %s", __multiline = "/* %s */" },
      },
    },
    autotag = {
      enable = true,
    },
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
      "gleam",
    },
    endwise = {
      enable = true,
    },
  },
  build = ":TSUpdate",
}
