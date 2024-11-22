vim.cmd([[
try
  colorscheme catppuccin-macchiato
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

require("transparent").setup({
	extra_groups = {
		"StatusLineNC",
		"StatusLine",
		"NvimTreeStatusLine",
		"NvimTreeNormal",
		"NvimTreeRootFolder",
		"NvimTreeNormalNC",
	},
})
