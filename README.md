# Dotfiles Repository

This repository contains my personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/), a dotfile manager that copies (rather than symlinks) files to their target locations, managing only what you explicitly declare.

## Getting Started

### Prerequisites

- macOS (primary platform)
- `git`
- `ghostty` terminal
- `aerospace` for managing windows — `brew install aerospace`
- `chezmoi` — `brew install chezmoi`
- `mise` for runtime version management — `brew install mise`

### Installing

1. Clone this repository to `~/.dotfiles`:

```bash
git clone https://github.com/TamerlanG/dotfiles.git ~/.dotfiles
```

2. Point chezmoi at the repo and apply:

```bash
chezmoi init --source ~/.dotfiles
chezmoi apply
```

### Keeping things in sync

After editing a file directly in `~` (e.g. `~/.tmux.conf`), pull the change back into the source:

```bash
chezmoi re-add ~/.tmux.conf
```

After editing a file in `~/.dotfiles` directly, apply it to `~`:

```bash
chezmoi apply
```

To preview what would change before applying:

```bash
chezmoi diff
```

## Repository Structure

Files follow chezmoi's naming convention:

| Source name | Target path |
|---|---|
| `dot_aerospace.toml` | `~/.aerospace.toml` |
| `dot_tmux.conf` | `~/.tmux.conf` |
| `dot_p10k.zsh` | `~/.p10k.zsh` |
| `dot_config/` | `~/.config/` |
| `Library/` | `~/Library/` |

## What is and isn't managed

**Managed by chezmoi** (tracked in this repo):
- `dot_aerospace.toml` — AeroSpace window manager
- `dot_tmux.conf` — tmux
- `dot_p10k.zsh` — Powerlevel10k prompt
- `dot_config/ghostty/` — Ghostty terminal
- `dot_config/nvim/` — Neovim
- `dot_config/fish/` — Fish shell
- `dot_config/mise/config.toml` — mise tool versions
- `dot_config/gh/config.yml` — GitHub CLI settings
- `dot_config/opencode/` — OpenCode AI assistant
- `Library/Application Support/k9s/skins/` — k9s color skins

**Not managed** (machine-specific, secrets, or runtime state):
- `~/.config/gcloud/` — GCloud SDK credentials and cache
- `~/.config/github-copilot/` — Copilot auth tokens
- `~/.config/gh/hosts.yml` — GitHub CLI auth tokens
- `~/.config/mise/.env` — Environment secrets
- `~/.config/bk.yaml` — Buildkite API token
- `~/.config/fish/fish_variables` — Fish runtime state
