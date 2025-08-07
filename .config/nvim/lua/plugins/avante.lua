return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = "BUILD_FROM_SOURCE=true make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    provider = "copilot",
    providers = {
      copilot = {
        model = "claude-sonnet-4"
      },
    },
    windows = {
      -- Increase sidebar width for better visibility
      width = 40,  -- default is 30, increased to 40%
      height = 35, -- default is 30, increased to 35%
      input = {
        provider = "snacks",
        height = 15, -- default is 8, increased to 15 for bigger input area
        provider_opts = {
          -- Additional snacks.input options
          title = "Avante Input",
          icon = " ",
        },
      },
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    --- The below dependencies are optional,
    "folke/snacks.nvim",           -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",      -- for providers='copilot'
  },
}
