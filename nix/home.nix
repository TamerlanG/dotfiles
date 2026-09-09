{ config, pkgs, ... }:

{
  home.username = "tamerlan";
  home.homeDirectory = "/Users/tamerlan";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    lsd
    zoxide
    kubectl
    gh
    lazygit
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
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
