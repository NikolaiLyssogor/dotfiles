return {
	"danymat/neogen",
	tag = "2.17.1",
	pin = true,
  event = "VeryLazy",
	config = function()
		require("neogen").setup({
			enabled = true,
			input_after_comment = true,
		})
		require("which-key").register({
			c = {
				name = "[c]ode",
				D = { ":Neogen<cr>", "generate [D]ocstring" },
			},
		}, { mode = "n", prefix = "<leader>" })
	end,
}
