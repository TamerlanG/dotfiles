local function ensure_parsers()
  local ok, ts = pcall(require, "nvim-treesitter")

  if not ok then
    return
  end

  local missing = vim.tbl_filter(function(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
  end, { "markdown", "markdown_inline" })

  if #missing > 0 then
    ts.install(missing)
  end
end

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle inline render", ft = "markdown" },
    },
    config = function(_, opts)
      ensure_parsers()
      require("render-markdown").setup(opts)
    end,
    opts = {
      completions = { blink = { enabled = true } },
      heading = { position = "inline" },
      code = { width = "block" },
    },
  },
  {
    "brianhuster/live-preview.nvim",
    cmd = { "LivePreview" },
    keys = {
      { "<leader>mp", "<cmd>LivePreview start<cr>", desc = "Web preview start", ft = "markdown" },
      { "<leader>mq", "<cmd>LivePreview close<cr>", desc = "Web preview close", ft = "markdown" },
    },
  },
}
