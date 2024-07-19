return {
	{
		"folke/neodev.nvim",
		tag = "v2.5.2",
		pin = true,
		opts = {},
	},
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
					"ruff_lsp",
					"clangd",
					-- "codelldb",
					"bashls",
					"pyright",

					"emmet_ls",
					"html",
					"tsserver",
					-- "eslint",
					"lua_ls",
					-- "shellcheck",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		commit = "e25c4cdecd3d58c0deccce0f372426c8c480bcce",
		pin = true,
		config = function()
			require("neodev").setup({})
			vim.lsp.set_log_level("debug")
			-- local util = require("lspconfig.util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.ruff_lsp({
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

			local function format()
				if vim.bo.filetype == "json" then
					vim.cmd(":%!jq .")
				else
					vim.lsp.buf.format()
				end
			end

			-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
			require("which-key").register({
				c = {
					name = "[c]ode",
					a = { ":lua vim.lsp.buf.code_action()<cr>", "code [a]ction" },
					c = { ":lua vim.diagnostic.open_float()<cr>", "show diagnosti[c]s" },
					d = { vim.lsp.buf.definition, "[d]efinition/declaration toggle" },
					f = { format, "[f]ormat code" },
					h = { ":lua vim.lsp.buf.hover()<cr>", "[h]over" },
					-- D = { vim.lsp.buf.declaration, "[D]eclaration" },
					-- i = { ":lua vim.lsp.buf.implementation()<cr>", "[i]mplementation" },
					n = { ":lua vim.lsp.buf.rename()<cr>", "re[n]ame" },
					r = { ":lua require('telescope.builtin').lsp_references()<cr><esc>", "[r]eferences" },
					t = { ":lua vim.lsp.buf.type_definition()<cr>", "[t]ype definition" },
				},
			}, { mode = "n", prefix = "<leader>" })
		end,
	},
}
