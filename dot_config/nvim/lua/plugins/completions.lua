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
	{
		"windwp/nvim-ts-autotag",
		commit = "e239a560f338be31337e7abc3ee42515daf23f5e",
		pin = true,
		ft = { "tsx", "jsx" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false,
					},
				},
			})
		end,
	},
}
