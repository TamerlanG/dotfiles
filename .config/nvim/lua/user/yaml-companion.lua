local status_ok, yaml_companion = pcall(require, "yaml-companion")
if not status_ok then
	return
end

local cfg = yaml_companion.setup({
	schemas = {},
})

require("lspconfig")["yamlls"].setup(cfg)
require("telescope").load_extension("yaml_schema")
