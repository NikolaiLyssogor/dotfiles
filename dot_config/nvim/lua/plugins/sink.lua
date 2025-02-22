return {
	{
		"NikolaiLyssogor/sink.nvim",
		dir = "~/Documents/personal-projects/sink.nvim/",
		dev = true,
		keys = {
			{ "<leader>rp", "<cmd>SinkPush<CR>", desc = "[p]ush to remote" },
			{ "<leader>rl", "<cmd>SinkPull<CR>", desc = "pu[l]l from remote" },
		},
		config = function()
			require("sink").setup({
				{
					directory = "/Users/nlyssogor/Documents/research/sync/HIA/",
					push = {
						args = {
							"-avz",
							"--delete",
							"--exclude-from",
							"/Users/nlyssogor/Documents/research/sync/rsync-exclude.txt",
							"/Users/nlyssogor/Documents/research/sync/HIA/src/",
							"nily9199@login.rc.colorado.edu:/projects/nily9199/sync/HIA/src/",
						},
					},
					pull = {
						args = {
							"-avz",
							"--exclude-from",
							"/Users/nlyssogor/Documents/research/sync/rsync-exclude.txt",
							"nily9199@login.rc.colorado.edu:/projects/nily9199/sync/HIA/notebooks/",
							"/Users/nlyssogor/Documents/research/sync/HIA/notebooks/",
						},
					},
				},
			})
		end,
	},
}
