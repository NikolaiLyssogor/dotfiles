return {
	{
		"neovim/nvim-lspconfig",
		tag = "v1.6.0",
		pin = true,
		event = { "BufReadPre", "BufNewFile" },
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
				function()
					require("snacks.picker").lsp_implementations()
				end,
				desc = "[i]mplementation",
			},
			{ "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "re[n]ame" },
			{
				"<leader>cr",
				function()
					require("snacks.picker").lsp_references()
				end,
				desc = "[r]eferences",
			},
			{
				"<leader>ct",
				"<cmd>lua vim.lsp.buf.type_definition()<cr>",
				desc = "[t]ype definition",
			},
			{ "<leader>cj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "next diagnostic" },
			{ "<leader>ck", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "prev diagnostic" },
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
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
			lspconfig.ruff.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				on_attach = on_attach,
				settings = {
          pyright = {
            -- use ruff for organizing imports
            disableOrganizeImports = true,
          },
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

			vim.lsp.set_log_level("off")

      -- show function signature when typing its arguments
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
				border = "single",
				close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }, -- InsertCharPre, BufHidden, CursorMoved
			})

      -- disable diagnostic virtual text
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = false,
					underline = false,
				})

      -- use line numbers as diagnostic signs
			vim.diagnostic.config({
				virtual_text = false,
				underline = true,
				signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
          }
        },
			})

		end,
	},
}
