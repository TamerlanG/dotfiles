require("mason").setup()
require("mason-lspconfig").setup()

lspconfig = require("lspconfig")

lsp_installer = require("mason-lspconfig")

local servers = {
	"jsonls",
	"lua_ls",
	"gopls",
	"tsserver",
	"pyright",
	"html",
	"tailwindcss",
	"emmet_ls",
	"dockerls",
	"bashls",
	"yamlls",
	"terraformls",
	"tflint",
	"golangci_lint_ls",
	"csharp_ls",
}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
