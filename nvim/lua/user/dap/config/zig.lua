local dap = require("dap")

dap.configurations.zig = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
