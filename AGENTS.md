# Repository Guidelines

## Project Overview

Personal macOS dotfiles for two machines (`aarch64-darwin`, user `tamerlan`): `mac` (personal) and `work` (Elastic laptop), managed declaratively with a Nix flake, nix-darwin, and Home Manager. Both hosts share `nix/darwin.nix` + `nix/home.nix`; per-host deltas live in `nix/hosts/*.nix`. App configs (nvim, fish, ghostty, aerospace, mise, herdr, omp) live as plain files in this repo; Nix wires them into `$HOME` and provisions the binaries they depend on.

## Architecture & Data Flow

```
make switch                      (CONFIG=work make switch on the work laptop)
  -> sudo darwin-rebuild switch --flake .#mac
    -> flake.nix : darwinConfigurations.{mac,work} = mkHost { user; host; }
       |- nix/darwin.nix          shared system layer: systemPackages, macOS defaults, fonts, Homebrew
       |- nix/hosts/<host>.nix    per-host: git identity; work also pins CONFIG=work
       '- nix/home.nix            shared user layer (home-manager.users.${user}): packages, programs.*, file links
          -> ~/.config/*, ~/.aerospace.toml, ~/.omp/agent/config.yml
```

Three distinct linking strategies in `nix/home.nix`; know which one a file uses before editing:

| Strategy | Files | Edit propagates |
|---|---|---|
| `live "<path>"` (`mkOutOfStoreSymlink` to `~/.dotfiles/<path>`) | `nvim/`, `mise/config.toml`, `herdr/config.toml`, `omp/agent/config.yml` | Immediately, no rebuild |
| Store symlink (`source = ../x`) | `aerospace/aerospace.toml`, `ghostty/config` | After `make switch` |
| Embedded via `builtins.readFile` | `fish/config.fish` (`programs.fish.interactiveShellInit`) | After `make switch` |

`wallpapers/main.jpg` is not linked; `nix/darwin.nix` activation runs `desktoppr all ${home}/.dotfiles/wallpapers/main.jpg` on both hosts.

Neovim flow: `nvim/init.lua` -> `lua/config/lazy.lua` (leader keys, `require("lazy").setup({ import = "plugins" })`) -> every `lua/plugins/*.lua` -> then `user.options`, `user.lsp`, `user.keymaps`, `user.autocommands`. `lazy.nvim` itself is not bootstrapped in-repo; it comes from `programs.neovim.plugins = [ lazy-nvim ]` in `nix/home.nix` (`sideloadInitLua = true` keeps HM's generated init separate from ours).

## Key Directories

- `nix/` — `darwin.nix` (shared system), `home.nix` (shared user), `hosts/{personal,work}.nix` (per-host deltas). All Nix logic outside `flake.nix`.
- `nvim/` — Neovim config. `lua/plugins/` lazy.nvim specs (auto-imported), `lua/user/` core setup, `lua/user/dap/{adapters,config}/` per-language DAP split, `ftdetect/` custom filetypes.
- `fish/`, `ghostty/`, `aerospace/`, `mise/`, `herdr/`, `omp/agent/` — one app per dir, single config file each (`herdr/` also has `focus-tab.sh`).
- `wallpapers/` — desktop image applied at activation.

## Development Commands

```sh
make switch        # = rebuild/apply: sudo darwin-rebuild switch --flake .#mac
make build         # nix build --no-link .#darwinConfigurations.mac.system (no activation)
make eval          # print toplevel drvPath; cheap syntax/eval check
make check         # statix + deadnix + nixfmt --check on flake.nix, nix/
make update        # nix flake update
make update-brew   # brew update && brew upgrade (switch never auto-updates Homebrew)
make fmt           # nix fmt (flake `formatter` = nixfmt from the pinned nixpkgs)
CONFIG=work make build    # select the work host ("mac" is the default)
```

Prefer `make eval` or `make build` to validate Nix edits; `make switch` needs sudo and mutates the machine — do not run it unprompted.

## Code Conventions & Common Patterns

**Nix**
- Formatted with `nixfmt` (`make fmt`), linted with statix/deadnix (`make check`; `statix.toml` disables `repeated_keys`). Inputs follow `nixpkgs` via `inputs.<x>.inputs.nixpkgs.follows`.
- Username is bound per host in `flake.nix` (`mkHost { user; host; }`) and passed via `specialArgs`/`extraSpecialArgs`; `nix/darwin.nix` derives `home`, `nix/home.nix` derives `home.homeDirectory`. Never write `tamerlan` or `/Users/tamerlan` in `nix/`.
- Host-specific settings go in `nix/hosts/<host>.nix`, which is a nix-darwin module and may set `home-manager.users.${user}.*` directly (git identity does this). Anything not host-specific stays in the shared layers.
- Add a CLI tool for the user: `home.packages` in `nix/home.nix`. System-wide/daemon-ish: `environment.systemPackages` in `nix/darwin.nix`. GUI app: `homebrew.casks` in `nix/darwin.nix`, or in a host module if only one machine needs it (`cleanup = "zap"` removes anything not listed; the work host overrides to `"none"`).
- Add a new `~/.config/<app>` file: `xdg.configFile."<app>/<file>".source = ../<app>/<file>;` — use `live "<app>/<file>"` if the config should be live-editable.

**Neovim (Lua)**
- One plugin per file in `lua/plugins/`, lowercase names (`whichkey.lua`, `typescript-tools.lua`). Files may return a single spec table or a list of specs (`general.lua`).
- Prefer `opts = {}`; use `config = function()` only when hooks/autocmds are needed (`lint.lua`, `dap.lua`).
- Dominant style: 2-space indent, double quotes. Some files drift (tabs/single quotes); match the file you are in, do not reformat.
- `<leader>` mappings go in `plugins/whichkey.lua` under existing groups (`<leader>d` debug, `<leader>l` LSP, etc.). `user/keymaps.lua` holds non-leader/legacy maps.
- LSP: `user/lsp.lua` uses `vim.lsp.config` + `vim.lsp.enable`; server defaults come from `nvim-lspconfig` (`plugins/lspconfig.lua`, loaded eagerly). No Mason: every LSP/formatter/linter binary is in `programs.neovim.extraPackages` in `nix/home.nix`. TypeScript uses `typescript-tools.nvim`, not lspconfig.
- Formatting: `plugins/conform.lua` `formatters_by_ft` (format on save, `lsp_fallback = true`). Linting: `plugins/lint.lua` `linters_by_ft` (eslint_d only when an ESLint config exists in cwd).
- New DAP language: add `user/dap/adapters/<lang>.lua` and `user/dap/config/<lang>.lua`, require both in `user/dap/init.lua`. Go is the exception (uses `dap-go` directly in `init.lua`; `config/go.lua` is empty).

**Shell**
- `fish/config.fish`: `abbr` for shortcuts (`cat`->`bat`, git aliases), `alias k=kubectl`. Shell integrations (zoxide `--cmd cd`, fzf keybinds, lsd `ls`/`ll`/`la`/`lt` aliases) come from `programs.*` in `nix/home.nix`, not from this file. Any tool referenced must be provisioned in `home.packages` or a `programs.*` module.

**Commits**
- Short imperative subjects with scope prefix: `darwin: ...`, `flake: ...`, `herdr: ...`, `nvim: ...`.

**Documentation**
- After a change, update `AGENTS.md`, `README.md`, or `nvim/README.md` only if the change alters something they state (commands, layout, link strategy, conventions). Keep docs lean: fix or remove the affected line, do not add narrative or duplicate what the code shows.

## Important Files

- `flake.nix` — `mkHost { user; host; }` -> `darwinConfigurations.{mac,work}`; exposes `formatter`; HM wired inline (`useGlobalPkgs`, `useUserPackages`, `extraSpecialArgs = { inherit user; }`, `users.${user} = import ./nix/home.nix`).
- `nix/darwin.nix` — `system.defaults` (dock/finder/trackpad/screencapture), fonts, Touch ID sudo, `environment.shells` (fish), `nix.gc`/`nix.optimise`, Homebrew (`brews`: omp, mole, herdr; `casks`: ghostty, arc, okta-verify, handy, hiddenbar; tap `can1357/tap`), Screenshots dir + wallpaper activation.
- `nix/hosts/personal.nix` — personal git email. `nix/hosts/work.nix` — Elastic git email, `home.sessionVariables.CONFIG = "work"`.
- `nix/home.nix` — packages, `programs.{git,delta,zoxide,fzf,bat,lsd,gh,lazygit,fish,neovim,mise}`, all dotfile links.
- `Makefile` — the operator interface; `CONFIG ?= mac`.
- `nvim/init.lua`, `nvim/lua/config/lazy.lua`, `nvim/lua/user/dap/init.lua`.
- `omp/agent/config.yml` — OMP agent model roles/provider order; live-symlinked.
- `mise/config.toml` — global `go = latest`, `rust = latest`.

## Runtime/Tooling Preferences

- Nix with flakes, nix-darwin, Home Manager (all on `nixpkgs-unstable`/master, pinned in `flake.lock`). No Node/Bun/Python project tooling.
- Homebrew only for casks and the brews above; everything else via Nix. `onActivation.autoUpdate`/`upgrade` are off; `make update-brew` is the only path that touches Homebrew versions. `nix.gc` (weekly, 14d) and `nix.optimise` run via launchd.
- Language toolchains (Go, Rust) via mise, not Nix.
- Repo must live at `~/.dotfiles` (`live` helper and wallpaper activation resolve there).
- No CI. `.gitignore` covers only `.DS_Store` and `result`.

## Testing & QA

No test suite. Validation is:
- Nix: `make eval` (fast eval), `make build` (full build, no activation), `make check` + `make fmt` before committing Nix.
- Neovim: config is live-symlinked; open `nvim` and run `:checkhealth` / `:Lazy` after plugin changes. `nvim/lazy-lock.json` is committed; run `:Lazy update` deliberately and commit the lockfile.
- Shell/ghostty/aerospace: require `make switch`, then reload (`aerospace reload-config`). herdr: live-symlinked; `herdr config check` then `herdr server reload-config`.
