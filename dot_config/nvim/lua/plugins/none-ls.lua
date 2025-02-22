return {
	"nvimtools/none-ls.nvim",
	commit = "75f74959f6471ca43a43a601d744a26393cc55c7",
	pin = true,
	event = "VeryLazy",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettier,
			},
		})
	end,
}
