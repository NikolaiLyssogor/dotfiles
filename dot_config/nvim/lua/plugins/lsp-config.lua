return {
	{
		"williamboman/mason.nvim",
		tag = "v1.10.0",
		pin = true,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.27.0",
		pin = true,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"bashls",
					"pyright",
					"ruff_lsp",
					"html",
					"tsserver",
					"tailwindcss",
					"lua_ls",
					"rust_analyzer",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		tag = "v0.1.8",
		pin = true,
		dependencies = { "saghen/blink.cmp" },
		keys = {
			{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code [a]ction" },
			{ "<leader>cc", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "show diagnosti[c]s" },
			{ "<leader>cd", vim.lsp.buf.definition, desc = "[d]efinition/declaration toggle" },
			{
				"<leader>cf",
				function()
					if vim.bo.filetype == "json" then
						vim.cmd(":%!jq .")
					else
						vim.lsp.buf.format()
					end
				end,
				desc = "[f]ormat code",
			},
			{ "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "[h]over" },
			-- D = { vim.lsp.buf.declaration, "[D]eclaration" },
			{
				"<leader>ci",
				"<cmd>Telescope lsp_implementations<cr><esc>",
				desc = "[i]mplementation",
			},
			{ "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "re[n]ame" },
			{ "<leader>cr", "<cmd>lua require('telescope.builtin').lsp_references()<cr><esc>", desc = "[r]eferences" },
			{
				"<leader>ct",
				"<cmd>lua vim.lsp.buf.type_definition()<cr>",
				desc = "[t]ype definition",
			},
			{ "<leader>cj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "next diagnostic" },
			{ "<leader>ck", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "prev diagnostic" },
		},
		config = function()
			vim.lsp.set_log_level("debug")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
				},
			})
			lspconfig.ruff_lsp.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							diagnosticMode = "openFilesOnly",
							typeCheckingMode = "strict", -- normal or strict
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
						},
					},
				},
			})

			vim.keymap.set("i", "<c-k>", function()
				vim.lsp.buf.signature_help()
			end, { buffer = true })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
				border = "single",
				close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }, -- InsertCharPre, BufHidden, CursorMoved
			})
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = false,
					underline = false,
				})

			vim.diagnostic.config({
				virtual_text = false,
				underline = true,
				signs = true,
			})

			vim.lsp.set_log_level("OFF")
		end,
	},
}
