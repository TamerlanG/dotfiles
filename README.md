# Dotfiles

Personal macOS dotfiles managed with nix-darwin and Home Manager. The repo must live at `~/.dotfiles`.

## Usage

```sh
make switch      # apply system + user config (sudo darwin-rebuild switch --flake .#mac)
make build       # build without switching
make eval        # print toplevel derivation path (quick eval check)
make update      # update flake inputs
make fmt         # format Nix files with nixfmt
make tmux-conf   # print the generated tmux.conf
```

`make help` lists all targets. `CONFIG=<name>` selects the flake configuration (default `mac`).

## Layout

- `flake.nix` — entrypoint; defines the `mac` configuration.
- `nix/darwin.nix` — system packages, macOS defaults, fonts, Homebrew, wallpaper activation.
- `nix/home.nix` — Home Manager packages, `programs.*`, and dotfile links.
- `fish/`, `tmux/`, `ghostty/`, `aerospace/` — app configs; embedded or symlinked at `make switch`.
- `nvim/`, `mise/`, `omp/agent/` — live-symlinked into `$HOME`; edits apply without a rebuild.
- `wallpapers/` — desktop image applied by the activation script.

See `AGENTS.md` for architecture, conventions, and editing guidelines.
