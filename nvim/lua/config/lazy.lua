-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy.nvim is provided by Home Manager through programs.neovim.plugins.
local ok, lazy = pcall(require, "lazy")
if not ok then
  error("lazy.nvim is unavailable; run Neovim from the Nix/Home Manager profile")
end

-- Setup lazy.nvim
lazy.setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
})
