local dap = require("dap")

local languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

local configs = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch File",
    program = "${file}",
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**" },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach (process)",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

for _, lang in ipairs(languages) do
  dap.configurations[lang] = dap.configurations[lang] or {}
  local existing = {}
  for _, c in ipairs(dap.configurations[lang]) do existing[c.name] = true end
  for _, cfg in ipairs(configs) do
    if not existing[cfg.name] then
      table.insert(dap.configurations[lang], cfg)
    end
  end
end
