return {
	"danymat/neogen",
	tag = "2.17.1",
	pin = true,
	keys = {
		{ "<leader>cD", ":Neogen<cr>", desc = "generate [D]ocstring" },
	},
	config = function()
		require("neogen").setup({
			enabled = true,
			input_after_comment = true,
		})
	end,
}
