local dap = require("dap")
if not dap.adapters["pwa-node"] then
  local mason = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
  local debugger_path = mason .. "/js-debug/src/dapDebugServer.js"
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = { command = "node", args = { debugger_path, "${port}" } },
  }
end
