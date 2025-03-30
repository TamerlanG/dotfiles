vim.cmd([[
try
  colorscheme oldworld
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
