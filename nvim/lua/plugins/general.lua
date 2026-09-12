return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Icons
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
