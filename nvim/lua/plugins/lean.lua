return {
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
}
