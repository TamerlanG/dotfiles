local M = {}

function M.setup()
  -- Eagerly load all adapters & configs (no autoload)
  pcall(require, "user.dap.adapters.go")
  pcall(require, "user.dap.config.go")
  pcall(require, "user.dap.adapters.js")
  pcall(require, "user.dap.config.js")
  pcall(require, "user.dap.adapters.zig")
  pcall(require, "user.dap.config.zig")

  require("user.dap.ui").setup()
end

return M
