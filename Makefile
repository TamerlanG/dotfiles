CONFIG ?= mac
HASH := \#
FLAKE ?= .$(HASH)$(CONFIG)
DARWIN_SYSTEM ?= .$(HASH)darwinConfigurations.$(CONFIG).system
TOPLEVEL_DRV ?= .$(HASH)darwinConfigurations.$(CONFIG).config.system.build.toplevel.drvPath

.PHONY: help switch rebuild apply build eval check update update-brew fmt

help:
	@printf '%s\n' \
	  'Targets:' \
	  '  make switch      Apply nix-darwin + Home Manager config' \
	  '  make build       Build the nix-darwin system without switching' \
	  '  make eval        Print the system toplevel derivation path' \
	  '  make check       Lint Nix files (statix, deadnix) and check formatting' \
	  '  make update      Update flake inputs' \
	  '  make update-brew Update and upgrade Homebrew formulae/casks' \
	  '  make fmt         Format Nix files' \
	  '' \
	  'Variables:' \
	  '  CONFIG=mac       nix-darwin configuration name'

switch rebuild apply:
	sudo darwin-rebuild switch --flake "$(FLAKE)"

build:
	nix build --no-link "$(DARWIN_SYSTEM)"

eval:
	nix eval --raw '$(TOPLEVEL_DRV)'

check:
	nix run nixpkgs#statix -- check .
	nix run nixpkgs#deadnix -- --fail flake.nix nix
	nix fmt -- --check flake.nix nix/*.nix nix/hosts/*.nix

update:
	nix flake update

update-brew:
	brew update && brew upgrade

fmt:
	nix fmt -- flake.nix nix/*.nix nix/hosts/*.nix
