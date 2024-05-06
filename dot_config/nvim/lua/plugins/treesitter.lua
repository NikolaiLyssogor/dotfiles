return {
	{
		"nvim-treesitter/nvim-treesitter",
    tag = "0.9.2",
    pin = true,
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "python", "yaml" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
