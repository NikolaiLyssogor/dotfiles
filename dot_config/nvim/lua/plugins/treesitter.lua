return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "5f38dffb6a07669a678f073bfe0f62b1a020dffc",
		pin = true,
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"javascript",
          "java",
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
