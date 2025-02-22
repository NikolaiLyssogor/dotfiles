return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "5774e7d3da4f681296a87fcd85d17779ad362a4f",
		pin = true,
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"javascript",
					"typescript",
					"tsx",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"python",
					"rust",
					"yaml",
				},
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
}
