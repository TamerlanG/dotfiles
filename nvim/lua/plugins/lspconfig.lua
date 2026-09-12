-- Loaded eagerly so its lsp/*.lua server defaults are on the runtimepath
-- before user/lsp.lua calls vim.lsp.enable. Binaries come from Nix
-- (programs.neovim.extraPackages), not Mason.
return {
  "neovim/nvim-lspconfig",
  lazy = false,
}
