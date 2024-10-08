return {
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v3.5.4",
		pin = true,
		config = function()
			require("ibl").setup({
				scope = {
					enabled = false,
				},
				exclude = { filetypes = { "codecompanion", "markdown" } },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		commit = "dbfc1c34bed415906395db8303c71039b3a3ffb4",
		pin = true,
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	commit = "0236521ea582747b58869cb72f70ccfa967d2e89",
	-- 	pin = true,
	-- 	opts = {},
	-- 	lazy = false,
	-- },
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
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,
				history = 100,
				enable_macro_history = false,
				on_select = {
					move_to_front = true,
				},
			})

			require("which-key").register({
				h = {
					name = "[h]elpers",
					c = { ":Telescope neoclip a extra=star,plus,b<cr><esc>", "[c]lipboard history" },
				},
			}, { mode = "n", prefix = "<leader>" })
		end,
	},
	{
		"karb94/neoscroll.nvim",
		commit = "21d52973bde32db998fc8b6590f87eb3c3c6d8e4",
		pin = true,
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				-- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				mappings = { "<C-y>", "<C-e>", "<C-u>", "<C-d>", "zt", "zz", "zb" },
				hide_cursor = false, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = "quadratic", -- Default easing function [quadratic, cubic, quartic, quintic, circular, sine]
				pre_hook = function()
					vim.wo.scroll = 7
				end, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
			})
		end,
	},
	{
		"echasnovski/mini.align",
		version = "*",
		pin = true,
		config = function()
			require("mini.align").setup({
				mappings = {
					start = " ha",
					start_with_preview = " hA",
				},
			})
			require("which-key").register({
				h = {
					name = "[h]elpers",
					a = { "[a]lign" },
					A = { "[A]lign with preview" },
				},
			}, { mode = "v", prefix = "<leader>" })
		end,
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
