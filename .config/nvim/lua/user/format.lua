local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
	experiments = {
		partial_update = "diff", -- or 'line-by-line'
	},
	exclude_path_patterns = {
		"/node_modules/",
		".local/share/nvim/lazy",
	},
	formatter_by_ft = {
		css = formatters.lsp,
		html = formatters.lsp,
		java = formatters.lsp,
		javascript = formatters.prettierd,
		json = formatters.lsp,
		lua = formatters.lsp,
		markdown = formatters.prettierd,
		openscad = formatters.lsp,
		python = formatters.black,
		rust = formatters.lsp,
		scad = formatters.lsp,
		scss = formatters.lsp,
		sh = formatters.shfmt,
		terraform = formatters.lsp,
		typescript = formatters.prettierd,
		typescriptreact = formatters.prettierd,
		yaml = formatters.prettierd,
		c = formatters.lsp,
		cs = formatters.lsp,
    svelete = formatters.lsp,
	},
})
