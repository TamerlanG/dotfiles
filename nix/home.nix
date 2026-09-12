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
      prettierd
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../fish/config.fish;
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
    "herdr/focus-tab.sh".source = live "herdr/focus-tab.sh";
  };
}
