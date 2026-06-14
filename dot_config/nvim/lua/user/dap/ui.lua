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

  require("nvim-dap-virtual-text").setup(
    {
      enabled = true,          -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      virt_text_pos = 'inline'
    }
  )
end

return M
