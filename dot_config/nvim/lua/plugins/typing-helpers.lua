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
}
