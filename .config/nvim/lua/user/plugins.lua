-- Automatically install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Define plugins
local plugins = {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "numToStr/Comment.nvim", tag = "v0.8.0" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "nvim-lualine/lualine.nvim" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	"christoomey/vim-tmux-navigator",

	-- Icons
	{ "nvim-tree/nvim-web-devicons" },

	-- Colorschemes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" },
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lua" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Snippets
	{ "L3MON4D3/LuaSnip", version = "v2.*" }, -- snippet engine

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{ "elentok/format-on-save.nvim" },
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		ft = { "yaml" },
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
	},

	-- Telescope
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	"xiyaowong/nvim-transparent",

	-- Git
	{ "lewis6991/gitsigns.nvim", commit = "fef5d90953f0a730483b44745fae5938ba8227f8" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rmagatti/auto-session",
		lazy = false,
	},
}

-- Setup plugins using lazy.nvim
require("lazy").setup(plugins, {})
