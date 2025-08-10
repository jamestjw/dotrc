return {
  "ibhagwan/fzf-lua",
  -- Optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- {
    --   "ff",
    --   -- <C-g> disables `.gitignore`
    --   ":FzfLua files cwd<CR>",
    --   desc = "[F]ind [f]iles",
    -- },
    {
      "fw",
      ":FzfLua live_grep_native<CR><C-g>",
      desc = "[F]ind [w]ord",
    },
    {
      "fb",
      ":FzfLua buffers<CR>",
      desc = "[F]ind [b]uffers",
    },
    {
      "fh",
      ":FzfLua help_tags query<CR>",
      desc = "[F]ind [h]elptags",
    },
    {
      "ft",
      ":FzfLua btags query<CR>",
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
    {
      "fq",
      ":FzfLua quickfix<CR>",
      mode = { "n" },
      desc = "[F]ind [q]uickfix",
    },
    {
      "fc",
      ":FzfLua grep_curbuf<CR>",
      mode = { "n" },
      desc = "[F]ind [c]urrent buffer",
    },
    {
      "fgc",
      ":FzfLua git_commits<CR>",
      mode = { "n" },
      desc = "[F]ind [g]it [c]ommits",
    },
    {
      "fgb",
      ":FzfLua git_branches<CR>",
      mode = { "n" },
      desc = "[F]ind [g]it [b]ranches",
    },
  },
  opts = function()
    local actions = require("fzf-lua.actions")
    -- calling `setup` is optional for customization
    return {
      -- "fzf-vim",
      "hide",
      grep = {
        actions = {
          ["ctrl-g"] = { actions.grep_lgrep },
          ["ctrl-r"] = { actions.toggle_ignore },
          ["ctrl-q"] = { fn = actions.file_sel_to_qf, prefix = "select-all" },
        },
      },
    }
  end,
}
