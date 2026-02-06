return {

	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				stubPath = vim.env.HOME .. "/typings",
				diagnosticSeverityOverrides = {
					reportUnusedImport = "information",
					reportUnusedFunction = "information",
					reportUnusedVariable = "information",
					reportGeneralTypeIssues = "none",
					reportOptionalMemberAccess = "none",
					reportOptionalSubscript = "none",
					reportPrivateImportUsage = "none",
				},
			},
		},
	},
}
