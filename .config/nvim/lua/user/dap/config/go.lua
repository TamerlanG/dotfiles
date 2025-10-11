local dap = require("dap")

dap.configurations.go = dap.configurations.go or {}

local custom = {
  {
    type = "go",
    name = "Debug File",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "Attach (process)",
    mode = "local",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

local existing_names = {}
for _, cfg in ipairs(dap.configurations.go) do existing_names[cfg.name] = true end
for _, cfg in ipairs(custom) do
  if not existing_names[cfg.name] then
    table.insert(dap.configurations.go, cfg)
  end
end
