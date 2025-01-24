return {
	{
		"windwp/nvim-autopairs",
		commit = "b464658e9b880f463b9f7e6ccddd93fb0013f559",
		pin = true,
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		tag = "v2.1.5",
		pin = true,
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"mawkler/modicator.nvim",
		commit = "780ea1e98c9bee8f3816685213b0aac42b34cd75",
		pin = true,
		dependencies = "catppuccin/nvim", -- Add your colorscheme plugin here
		config = function()
			require("modicator").setup()
		end,
		opts = {},
	},
	{
		"folke/snacks.nvim",
		tag = "v2.14.0",
		pin = true,
		opts = {
			scroll = {},
			indent = { animate = { enabled = false }, scope = { enabled = false } },
		},
	}
}
