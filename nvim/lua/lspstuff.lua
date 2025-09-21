local map = vim.keymap.set

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", function()
  require("dap").continue()
end)

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)

map("n", "<leader>dK", function()
  require("dap.ui.widgets").hover()
end)

map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<leader>dso", function()
  require("dap").step_over()
end)

map("n", "<leader>dsi", function()
  require("dap").step_into()
end)

map("n", "<leader>dl", function()
  require("dap").run_last()
end)

-- Lsp config

local on_attach = function(_, buffer)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = buffer }
  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "gr", vim.lsp.buf.references, bufopts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    on_attach(nil, args.buf)
  end,
})

vim.lsp.enable("pyright")

vim.lsp.config("racket_langserver", {
  filetypes = { ".rkt", ".scm" },
})
vim.lsp.enable("racket_langserver")

vim.lsp.enable("ocamllsp")

vim.lsp.enable("clojure_lsp")

vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
})
vim.lsp.enable("hls")

vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
vim.lsp.enable("lua_ls")

vim.lsp.enable("rust_analyzer")

vim.lsp.enable("gleam")

vim.lsp.enable("rescriptls")

vim.lsp.enable("csharp_ls")

-- Javascript, Vue
local node_modules_dir = vim.system({ "npm", "root", "-g" }):wait().stdout or ""

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = node_modules_dir .. "@vue/typescript-plugin/",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})
vim.lsp.enable("ts_ls")

local function get_typescript_server_path(root_dir)
  local util = require("lspconfig.util")
  local global_ts = node_modules_dir .. "typescript/lib/"
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

vim.lsp.config("vue_ls", {
  -- cmd = { "./node_modules/@vue/language-server/bin/vue-language-server.js", "--stdio" }
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
})
vim.lsp.enable("vue_ls")

-- Elixir LSP config

-- Lexical (we use elixirls for now since it has Dialyzer support)
--[[ local lexical_config = {
	filetypes = { "elixir", "eelixir", "heex" },
	cmd = { "/Users/jamestjw/Documents/source/elixir-stuff/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
	settings = {},
}

if not configs.lexical then
	configs.lexical = {
		default_config = {
			filetypes = lexical_config.filetypes,
			cmd = lexical_config.cmd,
			root_dir = function(fname)
				return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
			end,
			-- optional settings
			settings = lexical_config.settings,
		},
	}
end

lspconfig.lexical.setup({}) ]]

-- elixir-ls
vim.lsp.config("elixirls", {
  cmd = { "/usr/bin/elixir-ls/language_server.sh" },
})
vim.lsp.enable("elixirls")

vim.lsp.enable("gopls")

vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      linters = {
        ToDoHyphen = false,
        LongSentences = false,
        SentenceCapitalization = false,
      },
      codeActions = {
        ForceStable = true,
      },
      dialect = "British",
      isolateEnglish = true,
    },
  },
})
vim.lsp.enable("harper_ls")

vim.lsp.config("zls", {
  -- Server-specific settings. See `:help lspconfig-setup`

  -- omit the following line if `zls` is in your PATH
  -- cmd = { '/path/to/zls_executable' },
  -- There are two ways to set config options:
  --   - edit your `zls.json` that applies to any editor that uses ZLS
  --   - set in-editor config options with the `settings` field below.
  --
  -- Further information on how to configure ZLS:
  -- https://zigtools.org/zls/configure/
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics
      --
      -- Further information about build-on save:
      -- https://zigtools.org/zls/guides/build-on-save/
      -- enable_build_on_save = true,

      -- Neovim already provides basic syntax highlighting
      semantic_tokens = "partial",

      -- omit the following line if `zig` is in your PATH
      -- zig_exe_path = '/path/to/zig_executable'
    },
  },
})
vim.lsp.enable({ "zls" })

vim.lsp.enable("marksman")

-- LSP config END
