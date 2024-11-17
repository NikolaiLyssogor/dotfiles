return {
	"folke/which-key.nvim",
	tag = "v1.6.0",
	pin = true,
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local which_key = require("which-key")
		which_key.setup({})

		-- global which-key bindings
		which_key.register({
			l = { name = "[l]anguage models" },
			h = {
				name = "[h]elpers",
				n = { ":messages<cr>", "[n]otification history" },
			},
		}, { mode = "n", prefix = "<leader>" })
	end,
}
