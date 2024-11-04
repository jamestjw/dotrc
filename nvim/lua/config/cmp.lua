local cmp = require("cmp")

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }, {
    {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
  }, {
    -- Sourcegraph autocomplete (Cody)
    -- { name = "cody" },
  }),

  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- Comes from vsnip
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- I use tabs... some say you should stick to ins-completion but this is
    -- just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,

    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,

    ["<C-e>"] = cmp.mapping.abort(),

    ["<C-Space>"] = cmp.mapping.complete(),
  }),

  -- Avoid preselecting suggestions, so that pressing <CR> doesn't accidentally
  -- accept a suggestion.
  preselect = cmp.PreselectMode.None,
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

-- Auto pairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
