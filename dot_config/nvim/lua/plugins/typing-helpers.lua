return {
	{
		"windwp/nvim-autopairs",
		commit = "3d02855468f94bf435db41b661b58ec4f48a06b7",
		pin = true,
		event = "InsertEnter",
		opts = { map_cr = true }, -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		tag = "v2.3.2",
		pin = true,
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
}
