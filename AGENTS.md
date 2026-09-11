# Repository Guidelines

## Project Overview

Personal macOS dotfiles for a single machine (`aarch64-darwin`, user `tamerlan`, home `/Users/tamerlan`), managed declaratively with a Nix flake, nix-darwin, and Home Manager. App configs (nvim, fish, tmux, ghostty, aerospace, mise, omp) live as plain files in this repo; Nix wires them into `$HOME` and provisions the binaries they depend on.

## Architecture & Data Flow

```
make switch
  -> sudo darwin-rebuild switch --flake .#mac
    -> flake.nix : darwinConfigurations."mac"
       |- nix/darwin.nix   system layer: systemPackages, macOS defaults, fonts, Homebrew, activation script
       '- nix/home.nix     user layer (home-manager.users.tamerlan): packages, programs.*, file links
          -> ~/.config/*, ~/.aerospace.toml, ~/.omp/agent/config.yml
```

Three distinct linking strategies in `nix/home.nix`; know which one a file uses before editing:

| Strategy | Files | Edit propagates |
|---|---|---|
| `mkOutOfStoreSymlink` to `~/.dotfiles/...` | `nvim/`, `mise/config.toml`, `omp/agent/config.yml` | Immediately, no rebuild |
| Store symlink (`source = ../x`) | `aerospace/aerospace.toml`, `ghostty/config` | After `make switch` |
| Embedded via `builtins.readFile` | `fish/config.fish` (`programs.fish.interactiveShellInit`), `tmux/tmux.conf` (`programs.tmux.extraConfig`) | After `make switch` |

`wallpapers/main.jpg` is not linked; `nix/darwin.nix` activation runs `desktoppr all /Users/tamerlan/.dotfiles/wallpapers/main.jpg`.

Neovim flow: `nvim/init.lua` -> `lua/config/lazy.lua` (leader keys, `require("lazy").setup({ import = "plugins" })`) -> every `lua/plugins/*.lua` -> then `user.options`, `user.lsp`, `user.keymaps`, `user.autocommands`. `lazy.nvim` itself is not bootstrapped in-repo; it comes from `programs.neovim.plugins = [ lazy-nvim ]` in `nix/home.nix` (`sideloadInitLua = true` keeps HM's generated init separate from ours).

## Key Directories

- `nix/` — `darwin.nix` (system), `home.nix` (user). All Nix logic outside `flake.nix`.
- `nvim/` — Neovim config. `lua/plugins/` lazy.nvim specs (auto-imported), `lua/user/` core setup, `lua/user/dap/{adapters,config}/` per-language DAP split, `ftdetect/` custom filetypes.
- `fish/`, `tmux/`, `ghostty/`, `aerospace/`, `mise/`, `omp/agent/` — one app per dir, single config file each.
- `wallpapers/` — desktop image applied at activation.

## Development Commands

```sh
make switch        # = rebuild/apply: sudo darwin-rebuild switch --flake .#mac
make build         # nix build --no-link .#darwinConfigurations.mac.system (no activation)
make eval          # print toplevel drvPath; cheap syntax/eval check
make update        # nix flake update
make fmt           # nix run nixpkgs#nixfmt -- flake.nix nix/*.nix
make tmux-conf     # print HM-generated tmux.conf
CONFIG=other make build   # override flake attr (only "mac" exists today)
```

Prefer `make eval` or `make build` to validate Nix edits; `make switch` needs sudo and mutates the machine — do not run it unprompted.

## Code Conventions & Common Patterns

**Nix**
- Formatted with `nixfmt` (`make fmt`). Inputs follow `nixpkgs` via `inputs.<x>.inputs.nixpkgs.follows`.
- Add a CLI tool for the user: `home.packages` in `nix/home.nix`. System-wide/daemon-ish: `environment.systemPackages` in `nix/darwin.nix`. GUI app: `homebrew.casks` in `nix/darwin.nix` (`cleanup = "zap"` removes anything not listed).
- Add a new `~/.config/<app>` file: `xdg.configFile."<app>/<file>".source = ../<app>/<file>;` — use `mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/<app>"` if the config should be live-editable.
- tmux prefix (`C-a`) and plugins (catppuccin, vim-tmux-navigator, resurrect, continuum, session-wizard, tmux-fzf) are set in `programs.tmux` in `nix/home.nix`, not in `tmux/tmux.conf`. `tmux/tmux.conf` holds only keybind/style overrides.

**Neovim (Lua)**
- One plugin per file in `lua/plugins/`, lowercase names (`whichkey.lua`, `typescript-tools.lua`). Files may return a single spec table or a list of specs (`general.lua`).
- Prefer `opts = {}`; use `config = function()` only when hooks/autocmds are needed (`lint.lua`, `dap.lua`).
- Dominant style: 2-space indent, double quotes. Some files drift (tabs/single quotes); match the file you are in, do not reformat.
- `<leader>` mappings go in `plugins/whichkey.lua` under existing groups (`<leader>d` debug, `<leader>l` LSP, etc.). `user/keymaps.lua` holds non-leader/legacy maps.
- LSP: `user/lsp.lua` uses `vim.lsp.config` + `vim.lsp.enable`; `plugins/mason.lua` `ensure_installed` mirrors it. TypeScript uses `typescript-tools.nvim`, not lspconfig.
- Formatting: `plugins/conform.lua` `formatters_by_ft` (format on save, `lsp_fallback = true`). Linting: `plugins/lint.lua` `linters_by_ft` (eslint_d only when an ESLint config exists in cwd).
- New DAP language: add `user/dap/adapters/<lang>.lua` and `user/dap/config/<lang>.lua`, require both in `user/dap/init.lua`. Go is the exception (uses `dap-go` directly in `init.lua`; `config/go.lua` is empty).

**Shell**
- `fish/config.fish`: `abbr` for shortcuts (`ls`->`lsd`, `cat`->`bat`, git aliases), `alias k=kubectl`, `zoxide init fish --cmd cd`. Any tool referenced must be provisioned in `home.packages`.

**Commits**
- Short imperative subjects with scope prefix: `darwin: ...`, `flake: ...`, `tmux: ...`, `nvim: ...`.

**Documentation**
- After a change, update `AGENTS.md`, `README.md`, or `nvim/README.md` only if the change alters something they state (commands, layout, link strategy, conventions). Keep docs lean: fix or remove the affected line, do not add narrative or duplicate what the code shows.

## Important Files

- `flake.nix` — single output `darwinConfigurations."mac"`; HM wired inline (`useGlobalPkgs`, `useUserPackages`, `users.tamerlan = import ./nix/home.nix`).
- `nix/darwin.nix` — `system.defaults` (dock/finder/trackpad/screencapture), fonts, Touch ID sudo, Homebrew (`brews`: omp, mole; `casks`: ghostty, arc, okta-verify; tap `can1357/tap`), wallpaper activation.
- `nix/home.nix` — packages, `programs.{git,fish,tmux,neovim,mise}`, all dotfile links.
- `Makefile` — the operator interface; `CONFIG ?= mac`.
- `nvim/init.lua`, `nvim/lua/config/lazy.lua`, `nvim/lua/user/dap/init.lua`.
- `omp/agent/config.yml` — OMP agent model roles/provider order; live-symlinked.
- `mise/config.toml` — global `go = latest`, `rust = latest`.

## Runtime/Tooling Preferences

- Nix with flakes, nix-darwin, Home Manager (all on `nixpkgs-unstable`/master, pinned in `flake.lock`). No Node/Bun/Python project tooling.
- Homebrew only for casks and the two brews above; everything else via Nix.
- Language toolchains (Go, Rust) via mise, not Nix.
- Hardcoded paths: `/Users/tamerlan/.dotfiles` in `nix/home.nix` and `nix/darwin.nix`; repo must live at `~/.dotfiles`. `Makefile` hardcodes only the username (`users.tamerlan` in `tmux-conf`), no absolute paths.
- No CI. `.gitignore` covers only `.DS_Store` and `result`.

## Testing & QA

No test suite. Validation is:
- Nix: `make eval` (fast eval), `make build` (full build, no activation), `make fmt` before committing Nix.
- Neovim: config is live-symlinked; open `nvim` and run `:checkhealth` / `:Lazy` after plugin changes. No `lazy-lock.json` is committed.
- Shell/tmux/ghostty/aerospace: require `make switch`, then reload (`prefix+r` for tmux; `aerospace reload-config`).
