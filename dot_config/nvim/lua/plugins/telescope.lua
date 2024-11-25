return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		pin = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[g]rep" },
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		commit = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
		pin = true,
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "cf48d4dfce44e0b9a2e19a008d6ec6ea6f01a83b",
		pin = true,
		build = "make",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		keys = {
			{ "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "[f]ind files" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					frecency = {
            -- prevents the letter 'A' from being entered automatically on the first invocation
						db_safe_mode = false,
					},
				},
			})
		end,
	},
}
