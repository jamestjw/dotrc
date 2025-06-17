return {
  {
    "mlochbaum/BQN",
    ft = { "bqn" },
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editors/vim")
    end,
  },
  {
    "https://git.sr.ht/~detegr/nvim-bqn",
    ft = { "bqn" },
  },
}
