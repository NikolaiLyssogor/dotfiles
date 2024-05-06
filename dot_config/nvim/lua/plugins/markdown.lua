return {
	{
		"epwalsh/obsidian.nvim",
		tag = "v3.7.8", -- recommended, use latest release instead of latest commit
		pin = true,
		lazy = true,
		ft = { "markdown" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local vault_path = require("my-globals").get_vault_path()

			require("obsidian").setup({
				workspaces = {
					{
						name = "work",
						path = vault_path,
					},
				},
			})
		end,
	},
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

			require("which-key").register({
				o = {
					name = "[o]bsidian",
					n = { autolist.cycle_next_dr, "[n]ext list style" },
					p = { autolist.cycle_next_dr, "[p]revious list style" },
				},
			}, { mode = "n", prefix = "<leader>", expr = true })
		end,
	},
	{
		"lukas-reineke/headlines.nvim",
    tag = "v4.0.1",
    pin = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "codecompanion" },
		config = function()
			require("headlines").setup({
				-- codeblock_highlight = false,
				markdown = {
					query = vim.treesitter.query.parse(
						"markdown",
						[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock
            ]]
					),
					headline_highlights = { "Headline" },
					bullet_highlights = {
						"@text.title.1.marker.markdown",
						"@text.title.2.marker.markdown",
						"@text.title.3.marker.markdown",
						"@text.title.4.marker.markdown",
						"@text.title.5.marker.markdown",
						"@text.title.6.marker.markdown",
					},
					bullets = { "", "󰺕", "", "" },
					codeblock_highlight = "CodeBlock",
					dash_highlight = "Dash",
					dash_string = "-",
					fat_headlines = false,
					-- fat_headline_upper_string = "▃",
					-- fat_headline_lower_string = "🬂",
				},

				codecompanion = {
					query = vim.treesitter.query.parse(
						"markdown",
						[[
                            (atx_heading [
                                (atx_h1_marker)
                                (atx_h2_marker)
                                (atx_h3_marker)
                                (atx_h4_marker)
                                (atx_h5_marker)
                                (atx_h6_marker)
                            ] @headline)

                            (thematic_break) @dash

                            (fenced_code_block) @codeblock
                        ]]
					),
					treesitter_language = "markdown",
					headline_highlights = { "Headline" },
					bullet_highlights = {
						"@text.title.1.marker.markdown",
						"@text.title.2.marker.markdown",
						"@text.title.3.marker.markdown",
						"@text.title.4.marker.markdown",
						"@text.title.5.marker.markdown",
						"@text.title.6.marker.markdown",
					},
					bullets = { "", "󰺕", "", "" },
					codeblock_highlight = "CodeBlock",
					dash_highlight = "Dash",
					dash_string = "-",
					fat_headlines = false,
					-- fat_headline_upper_string = "▃",
					-- fat_headline_lower_string = "🬂",
				},
			})
		end,
	},
}
