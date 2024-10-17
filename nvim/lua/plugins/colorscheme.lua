-- return {
-- "catppuccin/nvim",
-- name = "catppuccin",
-- priority = 1000,
-- opts = function()
-- vim.cmd.colorscheme("catppuccin-mocha")
-- end,
-- }

-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   opts = function()
--     vim.cmd.colorscheme("kanagawa")
--   end
-- }

return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "warmer",
    })
    require("onedark").load()
  end,
}
