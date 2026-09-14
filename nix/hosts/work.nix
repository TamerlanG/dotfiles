{ pkgs, user, ... }:

{
  # Work-only GUI apps.
  environment.systemPackages = [ pkgs.slack ];

  home-manager.users.${user} = {
    programs.git.settings.user = {
      name = "Tamerlan Gudabayev";
      email = "tamerlan.gudabayev@elastic.co";
    };

    # Makefile reads CONFIG (default "mac"); pin it so a bare `make switch` targets this host.
    home.sessionVariables.CONFIG = "work";
  };
}
