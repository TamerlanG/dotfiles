local M = {}

function M.setup()
  local dap = require("dap")

  vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

  local ui = require("dapui")
  dap.listeners.before.attach.user_dap = function() ui.open() end
  dap.listeners.before.launch.user_dap = function() ui.open() end
  dap.listeners.before.event_terminated.user_dap = function() ui.close() end
  dap.listeners.before.event_exited.user_dap = function() ui.close() end

  -- Eagerly load all adapters & configs (no autoload)
  pcall(require, "user.dap.adapters.go")
  pcall(require, "user.dap.config.go")
  pcall(require, "user.dap.adapters.js")
  pcall(require, "user.dap.config.js")

  require("user.dap.ui").setup()
end

return M
