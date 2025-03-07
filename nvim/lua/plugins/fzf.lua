return {
  "ibhagwan/fzf-lua",
  -- Optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "ff",
      -- <C-g> disables `.gitignore`
      ":Files<CR>",
      -- ":Files<CR><C-g>"
      desc = "[F]ind [F]iles",
    },
    {
      "fw",
      -- ":RG<CR><C-g>",
      ":FzfLua live_grep_native<CR><C-g>",
      desc = "[F]ind [w]ord",
    },
    {
      "fb",
      ":Buffers<CR>",
      desc = "[F]ind [b]uffers",
    },
    {
      "fh",
      ":Helptags<CR>",
      desc = "[F]ind [h]elptags",
    },
    {
      "ft",
      ":BTags<CR>",
      desc = "[F]ind [t]ags",
    },
    {
      "fr",
      ":FzfLua live_grep_resume<CR>",
      desc = "[F]ind [r]esume",
    },
    {
      "fl",
      ":FzfLua grep_last<CR>",
      desc = "[F]ind [l]ast",
    },
    {
      "fu",
      ":FzfLua grep_cword<CR>",
      mode = { "n" },
      desc = "[F]ind [u]nder",
    },
    {
      "fu",
      ":FzfLua grep_visual<CR>",
      mode = { "v" },
      desc = "[F]ind [u]nder",
    },
  },
  opts = function()
    local actions = require("fzf-lua.actions")
    -- calling `setup` is optional for customization
    return {
      "fzf-vim",
      grep = {
        actions = {
          ["ctrl-r"] = { actions.toggle_ignore },
        },
      },
    }
  end,
}
