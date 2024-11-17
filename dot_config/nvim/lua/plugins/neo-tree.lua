return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>fd", "<cmd>Neotree filesystem reveal float<cr>", desc = "show [d]irectory" },
		{ "<leader>fb", "<cmd>Neotree buffers reveal float<cr>", desc = "show open [b]uffers" },
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					always_show = {
						".gitignore",
						".pre-commit-config.yaml",
            ".eslintrc.json",
            ".prettierrc"
					},
				},
			},
		})
	end,
}
