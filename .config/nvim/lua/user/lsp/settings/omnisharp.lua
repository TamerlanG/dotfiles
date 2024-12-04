local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"

return {
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
	settings = {
		Sdk = {
			path = "/Users/TGUDABAY/.asdf/shims/dotnet",
		},
	},
}
