{
  config,
  pkgs,
  user,
  ...
}:

let
  # Out-of-store symlink into the checkout: edits apply without a rebuild.
  live = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${path}";
in
{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tamerlan Gudabayev";
        email = "tamerlan@gudabayev.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options.navigate = true;
  };

  home.packages = with pkgs; [
    ripgrep
    kubectl
  ];

  # Shell integrations are on by default for fish.
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.lsd.enable = true;
  programs.gh.enable = true;
  programs.lazygit.enable = true;

  programs.mise.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # HM's generated init.lua (provider toggles) goes via the wrapper instead of
    # ~/.config/nvim/init.lua, which is ours and lives out of the store.
    sideloadInitLua = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    # Everything user/lsp.lua, plugins/conform.lua, plugins/lint.lua reference.
    extraPackages = with pkgs; [
      # LSP
      nil
      lua-language-server
      gopls
      rust-analyzer
      # formatters
      nixfmt
      stylua
      prettierd
      black
      isort
      # linters
      statix
      deadnix
      eslint_d
      pylint
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
    terminal = "tmux-256color";
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

          # "rounded" draws the caps with fg=#{@_ctp_status_bg},reverse which breaks
          # on a transparent (none) bar; hand-roll the same caps with bg=default.
          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_left_separator "#[fg=#{@thm_surface_0},bg=default]"
          set -g @catppuccin_window_middle_separator " "
          set -g @catppuccin_window_right_separator "#[fg=#{@thm_overlay_2},bg=default]"
          set -g @catppuccin_window_current_left_separator "#[fg=#{@thm_surface_1},bg=default]"
          set -g @catppuccin_window_current_middle_separator " "
          set -g @catppuccin_window_current_right_separator "#[fg=#{@thm_mauve},bg=default]"
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
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g status-right "#{E:@catppuccin_status_user}"
          set -ag status-right "#{E:@catppuccin_status_host}"
          set -ag status-right "#{E:@catppuccin_status_session}"
        '';
      }
      {
        plugin = session-wizard;
        extraConfig = "set -g @session-wizard 't'";
      }
      {
        plugin = tmux-fzf;
        extraConfig = ''
          TMUX_FZF_LAUNCH_KEY="o"
          bind-key "l" run-shell -b "TMUX_FZF_CLIENT='#{client_tty}' ${tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
        '';
      }
    ];

    extraConfig = ''
      ${builtins.readFile ../tmux/tmux.conf}

      set -g status-right-length 100
      set -g status-left ""
    '';
  };

  home.file = {
    ".aerospace.toml".source = ../aerospace/aerospace.toml;
    ".omp/agent/config.yml".source = live "omp/agent/config.yml";
  };

  xdg.configFile = {
    "ghostty/config".source = ../ghostty/config;
    "nvim".source = live "nvim";
    "mise/config.toml".source = live "mise/config.toml";
    "herdr/config.toml".source = live "herdr/config.toml";
  };
}
