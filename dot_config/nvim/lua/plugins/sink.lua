return {
	{
    "NikolaiLyssogor/sink.nvim",
		keys = {
			{ "<leader>Rp", "<cmd>SinkPush<CR>", desc = "[p]ush to remote" },
			{ "<leader>Rl", "<cmd>SinkPull<CR>", desc = "pu[l]l from remote" },
		},
		config = function()
			require("sink").setup({
				{
					source = "/Users/nlyssogor/Documents/research/sync/",
					dest = "nily9199@login.rc.colorado.edu:/projects/nily9199/sync/",
					exclude = "/Users/nlyssogor/Documents/research/sync/rsync-exclude.txt",
				},
			})
		end,
	},
}
