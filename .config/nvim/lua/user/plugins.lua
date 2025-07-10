-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Define plugins
local plugins = {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    cmd = { "ToggleTerm" },
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "nvim-lualine/lualine.nvim", event = "VeryLazy" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
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

  -- Telescope
  "nvim-telescope/telescope.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "xiyaowong/nvim-transparent",
    opts = {
      extra_groups = {
        "StatusLineNC",
        "StatusLine",
        "NvimTreeStatusLine",
        "NvimTreeNormal",
        "NvimTreeRootFolder",
        "NvimTreeNormalNC",
      },
    },
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    opts = {
      current_line_blame = true,
    },
    event = { "BufReadPost", "BufNewFile" },
  },
}

-- Setup plugins using lazy.nvim
require("lazy").setup(plugins, {})
