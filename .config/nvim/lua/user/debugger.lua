local dap, dapui = require("dap"), require("dapui")
local mason_nvim_dap = require("mason-nvim-dap")

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

mason_nvim_dap.setup({
	ensure_installed = {
		"cppdbg",
	},
	handlers = {}, -- sets up dap in the predefined manner
})
