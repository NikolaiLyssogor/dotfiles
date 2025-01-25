return {
	{
		"windwp/nvim-autopairs",
		commit = "b464658e9b880f463b9f7e6ccddd93fb0013f559",
		pin = true,
		event = "InsertEnter",
		opts = { map_cr = true }, -- this is equalent to setup({}) function
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
		"folke/snacks.nvim",
		tag = "v2.14.0",
		pin = true,
		opts = {
			scroll = {},
			indent = {
				animate = { enabled = false },
				scope = { enabled = false },
				filter = function(buf)
					-- disable indent guides for these filetypes
					local disabled_filetypes = { "markdown", "codecompanion" }
					local cur_filetype = vim.api.nvim_buf_get_option(buf, "filetype")

					for _, ft in ipairs(disabled_filetypes) do
						if cur_filetype == ft then
							return false
						end
					end

					-- original filter function code
					return vim.g.snacks_indent ~= false
						and vim.b[buf].snacks_indent ~= false
						and vim.bo[buf].buftype == ""
				end,
			},
		},
	},
}
