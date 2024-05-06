return {
	"folke/which-key.nvim",
	tag = "v1.6.0",
	pin = true,
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local which_key = require("which-key")
		which_key.setup({})
		local my_globals = require("my-globals")

		-- global which-key bindings
		which_key.register({
			h = {
				name = "[h]elpers",
				n = { ":messages<cr>", "[n]otification history" },
				i = {
					name = "[i]nsert code block",
					p = { my_globals.insert_py_chunk, "[p]ython fenced code block" },
					l = { my_globals.insert_lua_chunk, "[l]ua fenced code block" },
					b = { my_globals.insert_bash_chunk, "[b]ash fenced code block" },
					j = { my_globals.insert_js_chunk, "[j]avascript fenced code block" },
					c = { my_globals.insert_cpp_chunk, "[c]pp fenced code block" },
				},
			},
		}, { mode = "n", prefix = "<leader>" })
	end,
}
