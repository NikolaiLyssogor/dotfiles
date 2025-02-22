---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	single_file_support = true,
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
}
