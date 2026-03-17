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
- For Neovim configs: `rg` (ripgrep) and `fd` (fd) are required — e.g. `brew install ripgrep fd`

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
