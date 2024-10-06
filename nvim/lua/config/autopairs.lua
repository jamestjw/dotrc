local M = {}

function M.setup()
	local npairs = require("nvim-autopairs")
	local cond = require("nvim-autopairs.conds")
	npairs.setup({
		check_ts = true,
		enable_check_bracket_line = false,
	})

	-- Remove automatic single quotes in Scheme, Lisp and OCaml files.
	npairs.get_rule("'")[1].not_filetypes = { "scheme", "lisp", "ocaml" }
	npairs.get_rule("'")[1]:with_pair(cond.not_after_text("["))
end

return M
