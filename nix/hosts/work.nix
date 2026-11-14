{ pkgs, user, ... }:

{
  # Work-only apps and tools.
  environment.systemPackages = with pkgs; [
    slack
    buildkite-cli
    vault
    google-chrome
  ];

  # Merged with the shared lists in darwin.nix; cleanup = "zap" removes anything undeclared.
  homebrew.brews = [ "lima" ];
  homebrew.casks = [
    "gcloud-cli"
    "pgadmin4"
  ];

  home-manager.users.${user} = {
    programs.git.settings.user = {
      name = "Tamerlan Gudabayev";
      email = "tamerlan.gudabayev@elastic.co";
    };

    # Makefile reads CONFIG (default "mac"); pin it so a bare `make switch` targets this host.
    home.sessionVariables.CONFIG = "work";
  };
}
