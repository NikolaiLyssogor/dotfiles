---@type vim.lsp.Config
return {
	cmd = { "clangd", "--offset-encoding=utf-16" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
	},
	single_file_support = true,
}
