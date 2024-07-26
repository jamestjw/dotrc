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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, buffer)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = buffer }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local lspconfig = require("lspconfig")

lspconfig.util.default_config.on_attach = on_attach
lspconfig.util.default_config.flags = lsp_flags

lspconfig.pyright.setup({})

lspconfig.racket_langserver.setup({
	filetypes = { ".rkt", ".scm" },
})

lspconfig.ocamllsp.setup({})

lspconfig.clojure_lsp.setup({})

lspconfig.hls.setup({
	filetypes = { "haskell", "lhaskell", "cabal" },
	cmd = { "haskell-language-server-wrapper", "--lsp" },
})

lspconfig.clangd.setup({})

lspconfig.lua_ls.setup({
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

lspconfig.rust_analyzer.setup({})

-- LSP config END
