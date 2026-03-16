return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "javascript" }, -- only what you actually use
    highlight = { enable = true },
  },
  event = { "BufReadPost", "BufNewFile" },
}
