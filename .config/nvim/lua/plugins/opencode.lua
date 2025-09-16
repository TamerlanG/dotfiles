return {
  'NickvanDyke/opencode.nvim',
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `opts.auto_reload`
    vim.opt.autoread = true

    -- Recommended keymaps
    vim.keymap.set('n', '<leader>ot', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
    vim.keymap.set('n', '<leader>oA', function() require('opencode').ask() end, { desc = 'Ask opencode' })
    vim.keymap.set('n', '<leader>oa', function() require('opencode').ask('@cursor: ') end,
      { desc = 'Ask opencode about this' })
    vim.keymap.set('v', '<leader>oa', function() require('opencode').ask('@selection: ') end,
      { desc = 'Ask opencode about selection' })
    vim.keymap.set('n', '<leader>on', function() require('opencode').command('session_new') end,
      { desc = 'New opencode session' })
    vim.keymap.set('n', '<leader>oy', function() require('opencode').command('messages_copy') end,
      { desc = 'Copy last opencode response' })
    vim.keymap.set('n', '<S-C-u>', function() require('opencode').command('messages_half_page_up') end,
      { desc = 'Messages half page up' })
    vim.keymap.set('n', '<S-C-d>', function() require('opencode').command('messages_half_page_down') end,
      { desc = 'Messages half page down' })
    vim.keymap.set({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end,
      { desc = 'Select opencode prompt' })

    -- Example: keymap for custom prompt
    vim.keymap.set('n', '<leader>oe', function() require('opencode').prompt('Explain @cursor and its context') end,
      { desc = 'Explain this code' })
  end,
}
