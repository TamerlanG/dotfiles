{ user, ... }:

{
  home-manager.users.${user}.programs.git.settings.user = {
    name = "Tamerlan Gudabayev";
    email = "tamerlan@gudabayev.com";
  };
}
