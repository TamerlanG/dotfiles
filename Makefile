CONFIG ?= mac
HASH := \#
FLAKE ?= .$(HASH)$(CONFIG)
DARWIN_SYSTEM ?= .$(HASH)darwinConfigurations.$(CONFIG).system
TOPLEVEL_DRV ?= .$(HASH)darwinConfigurations.$(CONFIG).config.system.build.toplevel.drvPath

.PHONY: help switch rebuild apply build eval update fmt tmux-conf

help:
	@printf '%s\n' \
	  'Targets:' \
	  '  make switch      Apply nix-darwin + Home Manager config' \
	  '  make build       Build the nix-darwin system without switching' \
	  '  make eval        Print the system toplevel derivation path' \
	  '  make update      Update flake inputs' \
	  '  make fmt         Format Nix files' \
	  '  make tmux-conf   Print generated Home Manager tmux.conf' \
	  '' \
	  'Variables:' \
	  '  CONFIG=mac       nix-darwin configuration name'

switch rebuild apply:
	sudo darwin-rebuild switch --flake "$(FLAKE)"

build:
	nix build "$(DARWIN_SYSTEM)"

eval:
	nix eval --raw '$(TOPLEVEL_DRV)'

update:
	nix flake update

fmt:
	nix run nixpkgs#nixfmt -- flake.nix nix/*.nix

tmux-conf:
	nix eval --raw '.$(HASH)darwinConfigurations.$(CONFIG).config.home-manager.users.tamerlan.xdg.configFile."tmux/tmux.conf".text'
