return {
  "stevearc/oil.nvim",
  event = { "VimEnter */*,.*", "BufNew */*,.*" },
  keys = {
    {
      "<leader>o",
      function()
        require("oil").open()
      end,
      desc = "Open [O]il",
    },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
