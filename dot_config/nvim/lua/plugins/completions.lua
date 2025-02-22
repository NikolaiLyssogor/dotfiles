return {
	{
		"saghen/blink.cmp",
		-- use a release tag to download pre-built binaries
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',
		version = "*",
		pin = true,

		opts = {

			keymap = {
				preset = "default",
				["<Tab>"] = { "accept", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			snippets = { preset = "default" },

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			completion = {
				menu = { border = "single" },
				documentation = { window = { border = "single" } },
			},

			signature = { enabled = true, window = { border = "single" } },
		},

		opts_extend = { "sources.default" },
	},
}
