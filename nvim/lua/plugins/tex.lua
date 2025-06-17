return {
  "lervag/vimtex",
  ft = "tex", -- Only load on lua files
  -- uncomment to pin to a specific release
  -- tag = "v2.15",
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end,
}
