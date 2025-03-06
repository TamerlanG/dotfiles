# Dotfiles Repository

This repository contains my personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/), a symlink farm manager which makes it easy to install and manage dotfiles across multiple systems.

## Getting Started

These instructions will get you a copy of my dotfiles up and running on your local machine for development and testing purposes.

### Prerequisites

- A Unix-like operating system: macOS, Linux, or Unix
- `git` installed to clone the repository
- `ghostty` terminal I prefer
- `GNU Stow` installed to manage the symlinks
- `mise`
  - `brew install mise`
- `starship`
  - `brew install starship`

### Installing GNU Stow

1. Clone this repository to your home directory:

```bash
cd ~
git clone https://github.com/TamerlanG/dotfiles.git
cd .dotfiles
```

2. Use GNU Stow to symlink the desired configurations into your home directory:

```bash
stow .
```
