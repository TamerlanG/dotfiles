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
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "giuxtaposition/blink-cmp-copilot",
      { "saghen/blink.compat", lazy = true, version = false },
    },
    version = "1.*",
  },

  {
    "williamboman/mason.nvim",
    event = { "VeryLazy" },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "xiyaowong/nvim-transparent",
    opts = {
      extra_groups = {
        "StatusLineNC",
        "StatusLine",
        "SnacksPickerFile",
        "SnacksPicker",
        "SnacksPickerBorder"
      },
    },
  },
};
