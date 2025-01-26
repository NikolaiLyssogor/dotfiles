return {
	{
		"rmagatti/auto-session",
		tag = "v2.5.0",
		pin = true,
		lazy = false,
		keys = {
			{ "<leader>ss", "<cmd>Autosession search<cr>", desc = "[s]ession search" },
			{ "<leader>sd", "<cmd>Autosession delete<cr>", desc = "[d]elete session" },
		},
		config = function()
			require("auto-session").setup({
				suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
}
