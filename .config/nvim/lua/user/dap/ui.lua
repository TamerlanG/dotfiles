local M = {}

local function setup_virtual_text_when_ready()
  local ok, dap = pcall(require, "dap")
  if not ok or not dap.listeners then
    vim.schedule(setup_virtual_text_when_ready)
    return
  end
  require("nvim-dap-virtual-text").setup()
end

function M.setup()
  setup_virtual_text_when_ready()
  require("dapui").setup()
end

return M
