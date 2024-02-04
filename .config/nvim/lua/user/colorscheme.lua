vim.cmd [[
try
  colorscheme catppuccin-mocha
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

require("transparent").setup({
  extra_groups = {
    "StatusLineNC",
    "StatusLine",
    "NvimTreeStatusLine",
    "NvimTreeNormal",
    "NvimTreeRootFolder",
    "NvimTreeNormalNC"
  },
  exclude_groups = {
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected"
  },
})

