local blink = require("blink.cmp")

blink.setup({
  keymap = { preset = "default" },
  fuzzy = { implementation = "rust" },
  sources = {
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
      avante = {
        module = "blink-cmp-avante",
        name = "Avante",
      },
    },
    default = function()
      if vim.bo.filetype == "AvanteInput" then
        return { "avante" }
      end
      return { "copilot", "lsp", "path", "buffer" }
    end,
  },
  completion = { documentation = { auto_show = true }, ghost_text = { enabled = true } },
  appearance = {
    nerd_font_variant = "mono",
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release
    use_nvim_cmp_as_default = true,
    kind_icons = {
      Copilot = "",
      Text = "󰉿",
      Method = "󰊕",
      Function = "󰊕",
      Constructor = "󰒓",

      Field = "󰜢",
      Variable = "󰆦",
      Property = "󰖷",

      Class = "󱡠",
      Interface = "󱡠",
      Struct = "󱡠",
      Module = "󰅩",

      Unit = "󰪚",
      Value = "󰦨",
      Enum = "󰦨",
      EnumMember = "󰦨",

      Keyword = "󰻾",
      Constant = "󰏿",

      Snippet = "󱄽",
      Color = "󰏘",
      File = "󰈔",
      Reference = "󰬲",
      Folder = "󰉋",
      Event = "󱐋",
      Operator = "󰪚",
      TypeParameter = "󰬛",
    },
  },
})
