return {
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	cmd = {
		"clangd",
		"--query-driver=**",
		"--background-index",
		"--clang-tidy",
		"--compile-commands-dir=build",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	filetypes = {
		"c",
		"cc",
		"cpp",
	},
}
