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
			c = { name = "[c]ode" },
			f = { name = "[f]iles" },
			g = { name = "[g]it" },
			h = {
				name = "[h]elpers",
				n = { ":messages<cr>", "[n]otification history" },
			},
			l = { name = "[l]anguage models" },
			m = { name = "[m]arkdown" },
			r = { name = "[r]sync" },
			s = { name = "[s]essions" },
		}, { mode = "n", prefix = "<leader>" })
	end,
}
