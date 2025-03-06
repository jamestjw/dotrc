return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "ff",
      ":Telescope find_files<CR>",
      desc = "[F]ind [F]iles",
    },
    {
      "fw",
      ":Telescope grep_string<CR>",
      desc = "[F]ind [w]ord",
    },
    {
      "fb",
      ":Telescope buffers<CR>",
      desc = "[F]ind [b]uffers",
    },
    {
      "fh",
      ":Telescope help_tags<CR>",
      desc = "[F]ind [h]elptags",
    },
    {
      "ft",
      ":Telescope current_buffer_tags<CR>",
      desc = "[F]ind [t]ags",
    },
    {
      "fq",
      ":Telescope quickfix<CR>",
      desc = "[F]ind [q]uickfix",
    },
  },
  config = function()
    require("telescope").load_extension("fzf")
  end,
}
