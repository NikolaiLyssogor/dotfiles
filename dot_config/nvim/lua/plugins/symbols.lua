return {
	{
		"bassamsdata/namu.nvim",
		tag = "v0.2.0",
		opts = {
			namu_symbols = { enable = true },
			ui_select = { enable = false },
		},
		keys = {
			{
				"<leader>cs",
				":lua require('namu.namu_symbols').show()<CR>",
				mode = "n",
				silent = true,
				desc = "lsp symbols",
			},
		},
	},
}
