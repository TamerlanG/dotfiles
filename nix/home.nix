{ config, pkgs, ... }:

{
  home.username = "tamerlan";
  home.homeDirectory = "/Users/tamerlan";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user.email = "tamerlan@gudabayev.com";
  };

  home.packages = with pkgs; [
    bat
    ripgrep
    lsd
    zoxide
    kubectl
    gh
    lazygit
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      nil
      nixfmt
      statix
      deadnix
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../fish/config.fish;
  };

  home.file.".tmux.conf".source = ../tmux/tmux.conf;
  home.file.".aerospace.toml".source = ../aerospace/aerospace.toml;

  xdg.configFile."ghostty/config".source = ../ghostty/config;
  xdg.configFile."nvim".source = ../nvim;
}
