local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "super-tab" },
	sources = {
		providers = {
			obsidian = {
				name = "obsidian",
				module = "blink.compat.source",
			},
			obsidian_new = {
				name = "obsidian_new",
				module = "blink.compat.source",
			},
			obsidian_tags = {
				name = "obsidian_tags",
				module = "blink.compat.source",
			},
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
				transform_items = function(_, items)
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1
					CompletionItemKind[kind_idx] = "Copilot"
					for _, item in ipairs(items) do
						item.kind = kind_idx
					end
					return items
				end,
			},
		},
		completion = {
			enabled_providers = {
				"copilot",
				"lsp",
				"path",
				"buffer",
				"obsidian",
				"obsidian_new",
				"obsidian_tags",
			},
		},
	},
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
