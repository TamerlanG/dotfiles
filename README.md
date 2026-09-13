# Dotfiles

Personal macOS dotfiles managed with nix-darwin and Home Manager. The repo must live at `~/.dotfiles`.

## Usage

```sh
make switch      # apply system + user config (sudo darwin-rebuild switch --flake .#mac)
make build       # build without switching
make eval        # print toplevel derivation path (quick eval check)
make check       # statix + deadnix + nixfmt --check
make update      # update flake inputs
make update-brew # brew update && brew upgrade
make fmt         # format Nix files (nix fmt)
```

`make help` lists all targets. `CONFIG=<name>` selects the flake configuration: `mac` (personal, default) or `work` (`CONFIG=work make switch`).

## Layout

- `flake.nix` — entrypoint; `mkHost` builds the `mac` and `work` configurations from the shared layers plus one host module.
- `nix/darwin.nix` — shared system config: packages, macOS defaults, fonts, Homebrew.
- `nix/hosts/personal.nix`, `nix/hosts/work.nix` — per-host deltas: git identity; work also pins `CONFIG=work`.
- `nix/home.nix` — Home Manager packages, `programs.*`, and dotfile links.
- `fish/`, `ghostty/`, `aerospace/` — app configs; embedded or symlinked at `make switch`.
- `nvim/`, `mise/`, `herdr/`, `omp/agent/` — live-symlinked into `$HOME`; edits apply without a rebuild.
- `wallpapers/` — desktop image applied by the activation script.

See `AGENTS.md` for architecture, conventions, and editing guidelines.
