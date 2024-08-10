return {
	"nvimtools/none-ls.nvim",
	commit = "dca7ddec321a102ec9e792b1b29193702aff5fbb",
	pin = true,
	event = "VeryLazy",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.ruff,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettierd,
			},
		})
	end,
}
