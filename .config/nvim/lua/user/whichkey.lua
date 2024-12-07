local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	print("Failed to load which-key")
	return
end

-- Setup configuration for which-key
local setup = {
	preset = "modern",
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	win = {
		border = "rounded",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 2, 2, 2, 2 },
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
		align = "left",
	},
	show_help = true,
}

-- Key mappings specification
local spec = {
	-- AI and Copilot Chat related mappings
	{ "<leader>a", group = "ai" },
	{ "gm", group = "+Copilot chat" },
	{ "gmh", desc = "Show help" },
	{ "gmd", desc = "Show diff" },
	{ "gmp", desc = "Show system prompt" },
	{ "gms", desc = "Show selection" },
	{ "gmy", desc = "Yank diff" },
	{
		"<leader>ap",
		function()
			local actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
		end,
		desc = "CopilotChat - Prompt actions",
	},
	{
		"<leader>ap",
		":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
		mode = "x",
		desc = "CopilotChat - Prompt actions",
	},
	{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
	{ "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
	{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
	{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
	{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
	{
		"<leader>av",
		":CopilotChatVisual",
		mode = "x",
		desc = "CopilotChat - Open in vertical split",
	},
	{
		"<leader>ax",
		":CopilotChatInline<cr>",
		mode = "x",
		desc = "CopilotChat - Inline chat",
	},
	{
		"<leader>ai",
		function()
			local input = vim.fn.input("Ask Copilot: ")
			if input ~= "" then
				vim.cmd("CopilotChat " .. input)
			end
		end,
		desc = "CopilotChat - Ask input",
	},
	{
		"<leader>am",
		"<cmd>CopilotChatCommit<cr>",
		desc = "CopilotChat - Generate commit message for all changes",
	},
	{
		"<leader>aq",
		function()
			local input = vim.fn.input("Quick Chat: ")
			if input ~= "" then
				vim.cmd("CopilotChatBuffer " .. input)
			end
		end,
		desc = "CopilotChat - Quick chat",
	},
	{
		"<leader>ad",
		"<cmd>CopilotChatDebugInfo<cr>",
		desc = "CopilotChat - Debug Info",
	},
	{
		"<leader>af",
		"<cmd>CopilotChatFix<cr>",
		desc = "CopilotChat - Fix Diagnostic",
	},
	{
		"<leader>al",
		"<cmd>CopilotChatReset<cr>",
		desc = "CopilotChat - Clear buffer and chat history",
	},
	{
		"<leader>av",
		"<cmd>CopilotChatToggle<cr>",
		desc = "CopilotChat - Toggle",
	},
	{
		"<leader>a?",
		"<cmd>CopilotChatModels<cr>",
		desc = "CopilotChat - Select Models",
	},

	-- Telescope related mappings
	{
		"<leader>F",
		"<cmd>Telescope live_grep theme=ivy<cr>",
		desc = "Find Text",
		nowait = true,
		remap = false,
	},
	{
		"<leader>f",
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false}, { hidden = true })<cr>",
		desc = "Find files",
		nowait = true,
		remap = false,
	},
	{
		"<leader>t",
		group = "Telescope",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ty",
		"<cmd>Telescope yaml_schema<cr>",
		desc = "Yaml Schema",
		nowait = true,
		remap = false,
	},

	-- Buffer related mappings
	{
		"<leader>b",
		group = "Buffers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>bb",
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		desc = "List Buffers",
	},
	{
		"<leader>bo",
		"<cmd>%bd|e#<cr>",
		desc = "Close all buffers except current",
	},

	-- Git related mappings
	{
		"<leader>g",
		group = "Git",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gR",
		"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
		desc = "Reset Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gb",
		"<cmd>Telescope git_branches<cr>",
		desc = "Checkout branch",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gc",
		"<cmd>Telescope git_commits<cr>",
		desc = "Checkout commit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gd",
		"<cmd>Gitsigns diffthis HEAD<cr>",
		desc = "Diff",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gg",
		"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
		desc = "Lazygit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gj",
		"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
		desc = "Next Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gk",
		"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
		desc = "Prev Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gl",
		"<cmd>lua require 'gitsigns'.blame_line()<cr>",
		desc = "Blame",
		nowait = true,
		remap = false,
	},
	{
		"<leader>go",
		"<cmd>Telescope git_status<cr>",
		desc = "Open changed file",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gp",
		"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
		desc = "Preview Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gr",
		"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
		desc = "Reset Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gs",
		"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
		desc = "Stage Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gu",
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		desc = "Undo Stage Hunk",
		nowait = true,
		remap = false,
	},

	-- LSP related mappings
	{
		"<leader>l",
		group = "LSP",
		nowait = true,
		remap = false,
		icon = { icon = "🔍" },
	},
	{
		"<leader>lI",
		"<cmd>Mason<cr>",
		desc = "Installer Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lS",
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		desc = "Workspace Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		desc = "Code Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ld",
		"<cmd>Telescope lsp_document_diagnostics<cr>",
		desc = "Document Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format{async=true}<cr>",
		desc = "Format",
		remap = false,
	},
	{
		"<leader>li",
		"<cmd>LspInfo<cr>",
		desc = "Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lj",
		"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
		desc = "Next Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lk",
		"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
		desc = "Prev Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ll",
		"<cmd>lua vim.lsp.codelens.run()<cr>",
		desc = "CodeLens Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lq",
		"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
		desc = "Quickfix",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lr",
		"<cmd>lua vim.lsp.buf.rename()<cr>",
		desc = "Rename",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ls",
		"<cmd>Telescope lsp_document_symbols<cr>",
		desc = "Document Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lw",
		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
		desc = "Workspace Diagnostics",
		nowait = true,
		remap = false,
	},

	-- Neotest related mappings
	{
		"<leader>n",
		group = "🧪 Test",
		nowait = true,
		remap = false,
	},
	{
		"<leader>nr",
		"<cmd>lua require('neotest').run.run()<cr>",
		desc = "Run nearest test",
	},
	{
		"<leader>nf",
		"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
		desc = "Run current file",
	},
	{
		"<leader>na",
		"<cmd>lua require('neotest').run.run({ suite = true })<cr>",
		desc = "Run all tests",
	},
	{
		"<leader>nd",
		"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
		desc = "Debug nearest test",
	},
	{
		"<leader>ns",
		"<cmd>lua require('neotest').run.stop()<cr>",
		desc = "Stop test",
	},
	{
		"<leader>nn",
		"<cmd>lua require('neotest').run.attach()<cr>",
		desc = "Attach to nearest test",
	},
	{
		"<leader>no",
		"<cmd>lua require('neotest').output.open()<cr>",
		desc = "Show test output",
	},
	{
		"<leader>np",
		"<cmd>lua require('neotest').output_panel.toggle()<cr>",
		desc = "Toggle output panel",
	},
	{
		"<leader>nv",
		"<cmd>lua require('neotest').summary.toggle()<cr>",
		desc = "Toggle summary",
	},

	-- Debugger
	{
		"<leader>d",
		group = "Debugger",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dt",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "Continue",
		nowait = true,
		remap = false,
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "Step Into",
		nowait = true,
		remap = false,
	},
	{
		"<leader>do",
		function()
			require("dap").step_over()
		end,
		desc = "Step Over",
		nowait = true,
		remap = false,
	},
	{
		"<leader>du",
		function()
			require("dap").step_out()
		end,
		desc = "Step Out",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.open()
		end,
		desc = "Open REPL",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "Run Last",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dx",
		function()
			require("dap").terminate()
			require("dapui").close()
		end,
		desc = "Terminate",
		nowait = true,
		remap = false,
	},
	{
		"<leader>db",
		function()
			require("dap").list_breakpoints()
		end,
		desc = "List Breakpoints",
		nowait = true,
		remap = false,
	},
	{
		"<leader>de",
		function()
			require("dap").set_exception_breakpoints({ "all" })
		end,
		desc = "Set Exception Breakpoints",
		nowait = true,
		remap = false,
	},

	-- Search
	{
		"<leader>s",
		group = "Search",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sC",
		"<cmd>Telescope commands<cr>",
		desc = "Commands",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sM",
		"<cmd>Telescope man_pages<cr>",
		desc = "Man Pages",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sR",
		"<cmd>Telescope registers<cr>",
		desc = "Registers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sb",
		"<cmd>Telescope git_branches<cr>",
		desc = "Checkout branch",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sc",
		"<cmd>Telescope colorscheme<cr>",
		desc = "Colorscheme",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sh",
		"<cmd>Telescope help_tags<cr>",
		desc = "Find Help",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sk",
		"<cmd>Telescope keymaps<cr>",
		desc = "Keymaps",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sr",
		"<cmd>Telescope oldfiles<cr>",
		desc = "Open Recent File",
		nowait = true,
		remap = false,
	},

	-- Trouble
	{
		"<leader>x",
		group = "Trouble",
		nowait = true,
		remap = false,
		icon = { icon = "🚨" },
	},
	{
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Document Diagnostics",
	},
	{
		"<leader>xb",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>xw",
		"<cmd>Trouble workspace_diagnostics<cr>",
		desc = "Workspace Diagnostics",
	},
	{
		"<leader>xs",
		"<cmd>Trouble symbols toggle<cr>",
		desc = "Symbols",
	},
	{
		"<leader>xl",
		"<cmd>Trouble lsp toggle win.position=right<cr>",
		desc = "LSP Definitions/References",
	},
	{
		"<leader>xq",
		"<cmd>Trouble quickfix toggle<cr>",
		desc = "Quickfix List",
	},
	{
		"<leader>xL",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "Location List",
	},

	-- Neovim Configs
	{
		"<leader>p",
		group = "Configs",
	},
	{
		"<leader>pl",
		"<cmd>Lazy<cr>",
		desc = "Lazy",
		nowait = true,
		remap = false,
		icon = { icon = "🦥" },
	},

	-- Other mappings
	{
		"<leader>e",
		"<cmd>NvimTreeToggle<cr>",
		desc = "Explorer",
		nowait = true,
		remap = false,
		icon = { icon = "🌲" },
	},
	{
		"<leader>m",
		group = "Markdown",
		nowait = true,
		remap = false,
	},
	{
		"<leader>h",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "Harpoon",
		icon = { icon = "🎣" },
	},
	{
		"<leader>w",
		"<cmd>w!<CR>",
		desc = "Save",
		nowait = true,
		remap = false,
	},
}

-- Apply the setup and key mappings
which_key.setup(setup)
which_key.add(spec)
