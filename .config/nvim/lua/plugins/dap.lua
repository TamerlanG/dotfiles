return {
  "mfussenegger/nvim-dap",
  cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
  dependencies = {
    "igorlfs/nvim-dap-view",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
  },
  config = function()
    require("user.dap").setup()
  end,
  keys = {
    -- Core stepping
    { "<leader>dc", function() require("dap").continue() end,          desc = "Continue / Start" },
    { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
    { "<leader>du", function() require("dap").step_out() end,          desc = "Step Out" },

    -- Breakpoints
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Conditional Breakpoint"
    },

    -- Flow control
    { "<leader>dr", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>ds", function() require("dap").restart() end,       desc = "Restart Debugger" },
    { "<leader>dx", function() require("dap").terminate() end,     desc = "Stop Debugger" },

    -- Evaluate / Inspect
    {
      "<leader>de",
      function()
        vim.ui.input({ prompt = "Evaluate expression: " }, function(expr)
          if expr then require("dap").repl.execute(expr) end
        end)
      end,
      desc = "Evaluate Expression"
    },

    -- UI integration
    { "<leader>dd", function() require("dap-view").toggle() end, desc = "Toggle DAP UI" },
  },
}
