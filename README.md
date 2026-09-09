# Dotfiles

Personal macOS dotfiles managed with nix-darwin and Home Manager.

## Rebuild

From this repository:

```sh
sudo darwin-rebuild switch --flake .#mac
```

From anywhere:

```sh
sudo darwin-rebuild switch --flake ~/.dotfiles#mac
```

This applies both system config from `nix/darwin.nix` and user config from `nix/home.nix`.

## Layout

- `flake.nix` — nix-darwin entrypoint; defines the `mac` configuration.
- `nix/darwin.nix` — system packages, shell, fonts, Homebrew, and macOS-level settings.
- `nix/home.nix` — Home Manager packages, shell integrations, and user dotfile links.
- `fish/config.fish` — fish shell abbreviations, aliases, and zoxide init.
- `nvim/` — Neovim config.
- `ghostty/config` — Ghostty terminal config.
- `aerospace/aerospace.toml` — AeroSpace window manager config.
- `tmux/tmux.conf` — tmux config.

## Common commands

Preview the build target without switching:

```sh
nix eval --raw .#darwinConfigurations.mac.config.system.build.toplevel.drvPath
```

Update flake inputs:

```sh
nix flake update
```

Rebuild after updating inputs:

```sh
sudo darwin-rebuild switch --flake .#mac
```
