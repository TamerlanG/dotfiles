local status_ok, chat = pcall(require, "CopilotChat")
if not status_ok then
	return
end

local select = require("CopilotChat.select")

local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

local opts = {
	question_header = "## User",
	answer_header = "## Copilot ",
	error_header = "## Error ",
	prompts = prompts,
	auto_follow_cursor = false, -- Don't follow the cursor after getting response
	mappings = {
		-- Use tab for completion
		complete = {
			detail = "Use @<Tab> or /<Tab> for options.",
			insert = "<Tab>",
		},
		-- Close the chat
		close = {
			normal = "q",
			insert = "<C-c>",
		},
		-- Reset the chat buffer
		reset = {
			normal = "<C-x>",
			insert = "<C-x>",
		},
		-- Submit the prompt to Copilot
		submit_prompt = {
			normal = "<CR>",
			insert = "<C-CR>",
		},
		-- Accept the diff
		accept_diff = {
			normal = "<C-y>",
			insert = "<C-y>",
		},
		-- Yank the diff in the response to register
		yank_diff = {
			normal = "gmy",
		},
		-- Show the diff
		show_diff = {
			normal = "gmd",
		},
		-- Show the prompt
		show_system_prompt = {
			normal = "gmp",
		},
		-- Show the user selection
		show_user_selection = {
			normal = "gms",
		},
		-- Show help
		show_help = {
			normal = "gmh",
		},
	},
}

-- Use unnamed register for the selection
opts.selection = select.unnamed

chat.setup(opts)

vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
	chat.ask(args.args, { selection = select.visual })
end, { nargs = "*", range = true })

-- Inline chat with Copilot
vim.api.nvim_create_user_command("CopilotChatInline", function(args)
	chat.ask(args.args, {
		selection = select.visual,
		window = {
			layout = "float",
			relative = "cursor",
			width = 1,
			height = 0.4,
			row = 1,
		},
	})
end, { nargs = "*", range = true })

-- Restore CopilotChatBuffer
vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
	chat.ask(args.args, { selection = select.buffer })
end, { nargs = "*", range = true })

-- Custom buffer for CopilotChat
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "copilot-*",
	callback = function()
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true

		-- Get current filetype and set it to markdown if the current filetype is copilot-chat
		local ft = vim.bo.filetype
		if ft == "copilot-chat" then
			vim.bo.filetype = "markdown"
		end
	end,
})
