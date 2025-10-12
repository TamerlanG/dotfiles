local M = {}

function M.setup()
  require("nvim-dap-virtual-text").setup()
  require("dapui").setup()
end

return M
