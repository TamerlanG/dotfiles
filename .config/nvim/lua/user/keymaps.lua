local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local wk = require("which-key")

-- Visual Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Vertical Scrolling --
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

wk.add({
  { "<leader>d", group = "Debugger" },
  { "<leader>l", group = "LSP" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>o", group = "OpenCode" },
  { "<leader>R", group = "Kuala" },
  { "<leader>s", group = "Search" },
})
