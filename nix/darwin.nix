{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    aerospace
    fish
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
    ];

    taps = [
      {
        name = "can1357/tap";
        trusted = true;
      }
    ];

    casks = [
      "ghostty"
    ];
  };
}
