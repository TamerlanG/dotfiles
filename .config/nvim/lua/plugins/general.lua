return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  { "nvim-lualine/lualine.nvim",   event = "VeryLazy" },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  -- Icons
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

  -- Colorschemes
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        navic = true,
        alpha = false,
        rainbow_delimiters = false,
      },
      highlight_overrides = {
        Normal = { bg = 'NONE' },
        NormalNC = { bg = 'NONE' },
        CursorLine = { bg = '#222128' },
      },
    }
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    build = "cargo build --release",
    event = "InsertEnter",
    dependencies = {
      "fang2hou/blink-copilot",
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
  },
}
