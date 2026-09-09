return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		enable = true,
		library = {
			{ path = "snacks.nvim", words = { "Snacks" } },
		},
	},
}
