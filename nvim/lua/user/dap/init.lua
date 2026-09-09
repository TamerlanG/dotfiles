local M = {}

function M.setup()
  -- Eagerly load all adapters & configs (no autoload)
  require("dap-go").setup()

  pcall(require, "user.dap.adapters.js")
  pcall(require, "user.dap.config.js")
  pcall(require, "user.dap.adapters.zig")
  pcall(require, "user.dap.config.zig")

  require("user.dap.ui").setup()
end

return M
