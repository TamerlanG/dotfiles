return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    {
      "<leader>gv",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "Diffview Toggle",
    },
    {
      "<leader>gV",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "Diffview File History (current file)",
    },
    {
      "<leader>gp",
      "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
      desc = "Review Current PR",
    },

    {
      "<leader>gH",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "Diffview File History (repo)",
    },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
    },
  },
}
