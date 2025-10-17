local M = {}

local icons = {
  DapStopped             = "󰁕",
  DapBreakpoint          = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected  = "",
  DapLogPoint            = ">",
}

function M.setup()
  for k, v in pairs(icons) do
    vim.fn.sign_define(k, {
      text = v,
      texthl = k,
      linehl = "",
      numhl = "",
    })
  end

  require("nvim-dap-virtual-text").setup()
end

return M
