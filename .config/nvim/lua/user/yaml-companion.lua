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
		-- Override the schema association for deploy.yaml
		schemas = {
			["https://json.schemastore.org/github-workflow.json"] = "deploy.yaml",
		},
	},
})

require("lspconfig")["yamlls"].setup(cfg)
require("telescope").load_extension("yaml_schema")
