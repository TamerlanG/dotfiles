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

-- lazy.nvim itself lives in the read-only Nix store (nixpkgs already ships
-- doc/tags). Skip the helptags step for it, otherwise :Lazy update fails with
-- E152 trying to write doc/tags. Private API, so never let it break startup.
pcall(function()
  local docs = require("lazy.manage.task.plugin").docs
  local docs_skip = docs.skip
  docs.skip = function(plugin)
    return docs_skip(plugin) or not vim.uv.fs_access(plugin.dir .. "/doc", "W")
  end
end)

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
