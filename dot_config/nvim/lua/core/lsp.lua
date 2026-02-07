-- Catch-all config. This gets merged with configs in /lsp/<server>.lua
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git" },
})

-- jdtls configured differently since it's managed by nvim-jdtls
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local home = vim.uv.os_homedir()
local lombok_jar = home .. "/.local/share/java/lombok.jar"

-- Homebrew jdtls layout (Apple Silicon)
local jdtls_root = "/opt/homebrew/opt/jdtls/libexec"
local plugins_dir = jdtls_root .. "/plugins"

-- Find the Equinox launcher dynamically (versioned filename)
local equinox_candidates = vim.fs.find(function(name, path)
  return name:match("^org%.eclipse%.equinox%.launcher_.+%.jar$") ~= nil
end, { path = plugins_dir, type = "file", limit = 10 })

assert(#equinox_candidates > 0, "jdtls: Equinox launcher jar not found under: " .. plugins_dir)

-- Prefer the lexicographically greatest one
table.sort(equinox_candidates)
local equinox_launcher = equinox_candidates[#equinox_candidates]

vim.lsp.config("jdtls", {
  cmd = {
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_jar,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    equinox_launcher,

    "-configuration",
    jdtls_root .. "/config_mac_arm",

    "-data",
    workspace_dir,
  }
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
vim.lsp.enable("terraformls")
vim.lsp.enable("jdtls")
