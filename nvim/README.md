# Neovim

Managed by Home Manager: `~/.config/nvim` is an out-of-store symlink to this directory (`nix/home.nix`), so edits apply immediately. Neovim, `lazy.nvim`, and external tools (`extraPackages`) are provisioned by Nix; do not clone or install this config manually.

## Layout

- `init.lua` — loads `config.lazy`, then `user.options`, `user.lsp`, `user.keymaps`, `user.autocommands`.
- `lua/plugins/` — lazy.nvim specs, one plugin per file, auto-imported.
- `lua/user/` — options, LSP (`vim.lsp.config`/`vim.lsp.enable`), keymaps, autocommands.
- `lua/user/dap/` — `adapters/<lang>.lua` + `config/<lang>.lua`, wired in `init.lua`.
- `ftdetect/` — custom filetypes (e.g. `yaml.buildkite`).

## Health

```
:checkhealth
:Lazy
```
