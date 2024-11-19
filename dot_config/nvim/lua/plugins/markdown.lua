return {
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	tag = "v3.7.8", -- recommended, use latest release instead of latest commit
	-- 	pin = true,
	-- 	lazy = true,
	-- 	ft = { "markdown" },
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local vault_path = require("my-globals").get_vault_path()
	--
	-- 		require("obsidian").setup({
	-- 			workspaces = {
	-- 				{
	-- 					name = "work",
	-- 					path = vault_path,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"gaoDean/autolist.nvim",
		commit = "5f70a5f99e96c8fe3069de042abd2a8ed2deb855",
		pin = true,
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
			"codecompanion",
		},
		config = function()
			local autolist = require("autolist")
			local list_patterns = {
				neorg_1 = "%-",
				neorg_2 = "%-%-",
				neorg_3 = "%-%-%-",
				neorg_4 = "%-%-%-%-",
				neorg_5 = "%-%-%-%-%-",
				unordered = "[-+*]", -- - + *
				digit = "%d+[.)]", -- 1. 2. 3.
				ascii = "%a[.)]", -- a) b) c)
				roman = "%u*[.)]", -- I. II. III.
				latex_item = "\\item",
			}
			autolist.setup({
				colon = { -- if a line ends in a colon
					indent = false, -- if in list and line ends in `:` then create list
					indent_raw = false, -- above, but doesn't need to be in a list to work
				},
				lists = { -- configures list behaviours
					markdown = {
						list_patterns.unordered,
						list_patterns.digit,
						list_patterns.ascii, -- for example this specifies activate the ascii list
						list_patterns.roman, -- type for markdown files.
					},
					codecompanion = {
						list_patterns.unordered,
						list_patterns.digit,
						list_patterns.ascii, -- for example this specifies activate the ascii list
						list_patterns.roman, -- type for markdown files.
					},
				},
			})

			vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
			vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
			vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
			vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
			vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")
		end,
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		tag = "v6.0.0",
		pin = true,
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown", "codecompanion" },
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "codecompanion" },
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
		pin = true,
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}
