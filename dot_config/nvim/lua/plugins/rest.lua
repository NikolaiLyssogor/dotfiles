return {
	{
		"vhyrro/luarocks.nvim",
    commit = "d73f4bbbeea9eeb9b66a0c6431db402654f43cb8",
    pin = true,
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
    commit = "3fc2bb8b927a5001069ea5a53a93d47656823f14",
    pin = true,
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
			require("which-key").register({
				h = {
					name = "[h]elpers",
					r = { ":Rest run<cr>", "http [r]equest" },
				},
			}, { mode = "n", prefix = "<leader>" })
		end,
	},
}
