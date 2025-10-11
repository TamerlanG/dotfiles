local M = {}
local loaded = {}

local function ensure_dap()
  if package.loaded["dap"] then return true end
  local ok_lazy, lazy = pcall(require, "lazy")
  if ok_lazy then
    lazy.load({ plugins = { "nvim-dap" } })
    return package.loaded["dap"] ~= nil
  end
  return false
end

function M.load(lang)
  if not ensure_dap() then return end
  if loaded[lang] then return end
  pcall(require, "user.dap.adapters." .. lang)
  pcall(require, "user.dap.config." .. lang)
  loaded[lang] = true
end

return M
