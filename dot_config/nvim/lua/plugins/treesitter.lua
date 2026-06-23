return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true },
  },
  event = { "BufReadPost", "BufNewFile" },
}
