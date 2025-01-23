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
		"AckslD/nvim-neoclip.lua",
		commit = "798cd0592a81c185465db3a091a0ff8a21af60fd",
		pin = true,
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		keys = {
			{ "<leader>hc", "<cmd>Telescope neoclip a extra=star,plus,b<cr><esc>", desc = "[c]lipboard history" },
		},
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,
				history = 100,
				enable_macro_history = false,
				on_select = {
					move_to_front = true,
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		tag = "v2.14.0",
		pin = true,
		opts = {
			scroll = {},
			indent = { animate = { enabled = false }, scope = { enabled = false } },
		},
	},
	{
		"jinh0/eyeliner.nvim",
		commit = "7385c1a29091b98ddde186ed2d460a1103643148",
		pin = true,
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true, -- show highlights only after keypress
				dim = false, -- dim all other characters if set to true (recommended!)
				max_length = 9999, -- set the maximum number of characters eyeliner.nvim will check from
				disabled_filetypes = {}, -- filetypes for which eyeliner should be disabled;
				disabled_buftypes = {}, -- buftypes for which eyeliner should be disabled
				default_keymaps = true, -- add eyeliner to f/F/t/T keymaps;
			})
		end,
	},
}
