return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = { "<leader>nf" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = {
        -- "isort",
        "black",
      },
      ocaml = { "ocamlformat" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      vue = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shfmt" },
      sql = { "sqlfluff", "sqlfmt", stop_after_first = true },
      json = { "jq" },
    },
  },
  init = function()
    local conform = require("conform")

    conform.formatters.shfmt = {
      -- Indent with two spaces
      prepend_args = { "-i", "2" },
    }

    vim.keymap.set({ "n", "v" }, "<leader>nf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
