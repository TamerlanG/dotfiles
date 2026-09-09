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
    request = "launch",
    name = "Launch File (with args)",
    program = "${file}",
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**" },
    args = function()
      local input = vim.fn.input("Program arguments: ")
      return vim.split(input, " ", { trimempty = true })
    end,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach (process)",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Launch & Debug Chrome",
    url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({
          prompt = "Enter URL: ",
          default = "http://localhost:3000",
        }, function(url)
          if url == nil or url == "" then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end,
    webRoot = vim.fn.getcwd(),
    protocol = "inspector",
    sourceMaps = true,
    userDataDir = false,
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
