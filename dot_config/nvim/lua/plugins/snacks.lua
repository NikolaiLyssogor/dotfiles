return {
  {
    "nvim-tree/nvim-web-devicons",
    commit = "1020869742ecb191f260818234517f4a1515cfe8",
    pin = true,
  },
	{
		"folke/snacks.nvim",
		tag = "v2.21.0",
		pin = true,
		priority = 1000,
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.smart({
						filter = { cwd = true },
					})
				end,
				desc = "[f]ind files",
			},
      {
        "<leader>fg",
        function ()
          Snacks.picker.grep()
        end,
        desc = "live [g]rep"
      },
      {
        "<leader>fd",
        function ()
          Snacks.explorer()
        end,
        desc = "[d]irectory explorer"
      },
      {
        "<leader>fs",
        function()
          Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
        end,
        desc = "[s]ymbols picker"
      }
		},
		opts = {

			explorer = {},
			scroll = {},
			picker = {},

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
