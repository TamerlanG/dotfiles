local M = {}

function M.setup()
  local dap = require("dap")

  vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

  local ui = require("dapui")
  dap.listeners.before.attach.user_dap = function() ui.open() end
  dap.listeners.before.launch.user_dap = function() ui.open() end
  dap.listeners.before.event_terminated.user_dap = function() ui.close() end
  dap.listeners.before.event_exited.user_dap = function() ui.close() end

  -- Autoload adapters/configs on file open
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function(ev)
      require("user.dap.loader").load(ev.match)
    end,
  })

  -- Also load currently open buffers matching filetypes (if config run after they exist)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local ft = vim.bo[buf].filetype
      if ft ~= "" and ft:match("go") or ft:match("javascript") or ft:match("typescript") then
        require("user.dap.loader").load(ft)
      end
    end
  end

  -- UI setup after dap core is present
  require("user.dap.ui").setup()
end

return M
