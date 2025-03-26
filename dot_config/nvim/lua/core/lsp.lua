-- Catch-all config. This gets merged with configs in /lsp/<server>.lua
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		-- lsp keymaps
		local keymap_options = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_options)
		vim.keymap.set("n", "<leader>cc", vim.diagnostic.open_float, keymap_options)
		vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, keymap_options)
		vim.keymap.set("n", "<leader>cf", function()
			if vim.bo.filetype == "json" then
				vim.cmd(":%!jq .")
			else
				vim.lsp.buf.format()
			end
		end, keymap_options)
		vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, keymap_options)
		vim.keymap.set("n", "<leader>ci", require("snacks.picker").lsp_implementations, keymap_options)
		vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, keymap_options)
		vim.keymap.set("n", "<leader>cr", require("snacks.picker").lsp_references, keymap_options)
		vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, keymap_options)
		vim.keymap.set("n", "<leader>cj", vim.diagnostic.goto_next, keymap_options)
		vim.keymap.set("n", "<leader>ck", vim.diagnostic.goto_prev, keymap_options)

		-- disable logs as they can grow quite large
		vim.lsp.set_log_level("off")

		-- show function signature when typing its arguments
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
			border = "single",
			close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
		})

		-- use line numbers as diagnostic signs
		vim.diagnostic.config({
			virtual_text = false,
			underline = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
					[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticHint",
				},
			},
		})
	end,
})

-- enable language servers configured in /lsp/<server>.lua
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
