return {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			format = {
				enable = true,
				singleQuote = true,
			},
			validate = true,
			hover = true,
			completion = true,
			schemaStore = {
				url = "https://www.schemastore.org/api/json/catalog.json",
				enable = true,
			},
			customTags = {
				"!fn",
				"!And",
				"!If",
				"!Not",
				"!Equals",
				"!Or",
				"!FindInMap sequence",
				"!Base64",
				"!Cidr",
				"!Ref",
				"!Ref Scalar",
				"!Sub",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!Select",
				"!Split",
				"!Join sequence",
			},
		},
	},
}
