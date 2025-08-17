vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo,checkhealth, nnoremap <silent> <buffer> q :close<CR>
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
]])

-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
--   callback = function(data)
--     -- skip if Neovim was opened with a file
--     if vim.fn.argc() > 0 then return end
--     -- don’t load if CWD is home (you probably want per‑project sessions)
--     if vim.fn.getcwd() == vim.env.HOME then return end
--     -- if a session file exists, load it
--     require("persistence").load()
--   end,
--   nested = true, -- important so BufRead events fire after session restore
-- })
