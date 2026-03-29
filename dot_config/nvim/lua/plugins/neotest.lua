return {
  "nvim-neotest/neotest",
  cmd = { "Neotest", "NeotestSummary", "NeotestOutput" },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      summary = {
        open = "botright vsplit | vertical resize 80",
      },
      adapters = {
        require("neotest-jest")({
          jestCommand = "yarn test:jest --",
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}
