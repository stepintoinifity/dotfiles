return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			analyses = {
				ST1003 = true,
				fieldalignment = false,
				fillreturns = true,
				nilness = true,
				nonewvars = true,
				shadow = true,
				undeclaredname = true,
				unreachable = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			codelenses = {
				gc_details = true, -- Show a code lens toggling the display of gc's choices.
				generate = true, -- show the `go generate` lens.
				regenerate_cgo = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			buildFlags = { "-tags", "integration" },
			completeUnimported = true,
			diagnosticsDelay = "200ms",
			matcher = "Fuzzy",
			semanticTokens = true,
			staticcheck = true,
			symbolMatcher = "fuzzy",
			usePlaceholders = true,
		},
	},
}
