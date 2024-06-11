local M = {}

function M.setup()
	local npairs = require("nvim-autopairs")
	local cond = require("nvim-autopairs.conds")
	npairs.setup({
		check_ts = true,
		enable_check_bracket_line = false,
	})
	npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

	-- remove add single quote on filetype scheme or lisp
	npairs.get_rule("'")[1].not_filetypes = { "scheme", "lisp" }
	npairs.get_rule("'")[1]:with_pair(cond.not_after_text("["))
end

return M
