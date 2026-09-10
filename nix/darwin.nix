{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    tmux
    aerospace
    fish
    betterdisplay
  ];

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.users.tamerlan = {
    home = "/Users/tamerlan";
    shell = pkgs.fish;
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  system.stateVersion = 6;
  system.primaryUser = "tamerlan";

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "betterdisplay"
    ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    brews = [
      "omp"
      "mole"
    ];

    taps = [
      {
        name = "can1357/tap";
        trusted = true;
      }
    ];

    casks = [
      "ghostty"
      "arc"
    ];
  };
}
