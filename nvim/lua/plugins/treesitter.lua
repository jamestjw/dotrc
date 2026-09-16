local parsers = {
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
  "elixir",
  "heex",
  "gleam",
  "cpp",
  "terraform",
  "rust",
  "elm",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang or not vim.list_contains(parsers, lang) then
          return
        end

        if pcall(vim.treesitter.start, args.buf, lang) and vim.treesitter.query.get(lang, "indents") then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
