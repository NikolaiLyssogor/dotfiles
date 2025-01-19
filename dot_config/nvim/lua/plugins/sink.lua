return {
	{
    "NikolaiLyssogor/sink.nvim",
		keys = {
			{ "<leader>Rp", "<cmd>SinkPush<CR>", desc = "[s]ync to remote" },
		},
		config = function()
			require("sink").setup({
				{
					source = "/Users/nlyssogor/Documents/research/sync/",
					dest = "nily9199@login.rc.colorado.edu:/projects/nily9199/sync/",
					exclude = "/Users/nlyssogor/Documents/research/scripts/rsync-exclude.txt",
				},
			})
		end,
	},
}
