return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		pin = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"/Users/nqxl/Documents/summary-app/qrt-qh-csr-gen-ai-summary/application-source/test/docs",
					},
				},
			})
			local builtin = require("telescope.builtin")
      local open_marks_picker_in_normal = function()
        builtin.marks()
        local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
        vim.api.nvim_feedkeys(key, "n", false)
      end
			require("which-key").register({
				f = {
					name = "[f]iles",
					f = { builtin.find_files, "[f]ind files" },
					g = { builtin.live_grep, "live [g]rep" },
				},
				h = {
					name = "[h]elpers",
					m = { open_marks_picker_in_normal, "[m]arks" },
				},
			}, { mode = "n", prefix = "<leader>" })
		end,
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
		commit = "9ef21b2e6bb6ebeaf349a0781745549bbb870d27",
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
}
