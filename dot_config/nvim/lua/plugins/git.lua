return {
	{
		"lewis6991/gitsigns.nvim",
		commit = "c097cb255096f333e14d341082a84f572b394fa2",
		pin = true,
    lazy = false,
		keys = {
			{ "<leader>gd", "<cmd>Gitsigns preview_hunk<CR>", desc = "[d]iff preview" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "[r]eset hunk" },
			{ "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", desc = "[n]ext hunk" },
			{ "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", desc = "[p]revious hunk" },
		},
		config = function()
			require("gitsigns").setup()
		end,
	},
}
