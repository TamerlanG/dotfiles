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
    fzf
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

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    terminal = "screen-256color";
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    escapeTime = 10;
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_status_background "none"

          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_text "#W"
          set -g @catppuccin_window_number "#I"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_current_number "#I"

          set -g @catppuccin_status_left_separator " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = session-wizard;
        extraConfig = "set -g @session-wizard 't'";
      }
      {
        plugin = tmux-fzf;
        extraConfig = ''
          TMUX_FZF_LAUNCH_KEY="C-o"
          bind-key "l" run-shell -b "TMUX_FZF_CLIENT='#{client_tty}' ${tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
        '';
      }
    ];

    extraConfig = ''
      ${builtins.readFile ../tmux/tmux.conf}

      set -g status-right-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_user}"
      set -ag status-right "#{E:@catppuccin_status_host}"
      set -ag status-right "#{E:@catppuccin_status_session}"
    '';

  };
  home.file.".aerospace.toml".source = ../aerospace/aerospace.toml;

  xdg.configFile."ghostty/config".source = ../ghostty/config;
  xdg.configFile."nvim".source = ../nvim;
}
