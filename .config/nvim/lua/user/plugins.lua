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
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
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
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
		event = { "BufReadPost", "BufNewFile" },
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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		event = "VeryLazy",
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"giuxtaposition/blink-cmp-copilot",
			{ "saghen/blink.compat", lazy = true, version = false },
		},
		lazy = false, -- lazy loading handled internally
		event = "InsertEnter",
		version = "v0.*",
	},

	{
		"williamboman/mason.nvim",
		event = { "VeryLazy" },
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = { "VeryLazy" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
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
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "VeryLazy",
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
	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		opts = {
			-- your options here
		},
	},
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
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
	{
		"lewis6991/gitsigns.nvim",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rmagatti/auto-session",
		lazy = false,
	},

	-- Testing
	{
		"nvim-neotest/neotest",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
	},

	-- Obsidian
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			-- refer to `:h file-pattern` for more examples
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Home/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Home/*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			ui = {
				enable = false,
			},
			workspaces = {
				{
					name = "home",
					path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Home",
				},
			},
		},
	},
}

-- Setup plugins using lazy.nvim
require("lazy").setup(plugins, {})
