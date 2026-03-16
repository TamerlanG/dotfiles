return {
  'NickvanDyke/opencode.nvim',
  config = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = "tmux",
      }
    }

    -- Required for `opts.auto_reload`
    vim.opt.autoread = true
  end,
}
