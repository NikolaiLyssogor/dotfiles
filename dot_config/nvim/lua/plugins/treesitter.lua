return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "176e4464736c1feca190d77f481ed5972b513516",
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
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
