local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
	return
end

local jest = require("neotest-jest")

neotest.setup({
	summary = {
		open = "botright vsplit | vertical resize 80",
	},
	adapters = {
		jest({
			jestCommand = "npm test --",
			cwd = function(path)
				return vim.fn.getcwd()
			end,
		}),
	},
})
