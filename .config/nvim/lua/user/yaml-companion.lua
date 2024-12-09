local status_ok, yaml_companion = pcall(require, "yaml-companion")
if not status_ok then
	return
end

local cfg = yaml_companion.setup({
	lspconfig = {
		-- Enable the built-in schema store
		schemaStore = {
			enable = true,
		},
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
				},
			},
		},
	},
})

require("lspconfig")["yamlls"].setup(cfg)
require("telescope").load_extension("yaml_schema")
