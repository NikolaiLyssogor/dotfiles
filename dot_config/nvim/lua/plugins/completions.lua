return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		tag = "v2.2.0",
		pin = true,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-path",
		commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
		pin = true,
	},
	{
		"hrsh7th/nvim-cmp",
		commit = "ce16de5665c766f39c271705b17fff06f7bcb84f",
		pin = true,
		config = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require("cmp")

      cmp.event:on(
        'confirm_done',
          cmp_autopairs.on_confirm_done()
      )

			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				confirmation = { completeopt = "menu,menuone,noinsert,preview" },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					-- { name = "otter" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		commit = "e239a560f338be31337e7abc3ee42515daf23f5e",
		pin = true,
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
