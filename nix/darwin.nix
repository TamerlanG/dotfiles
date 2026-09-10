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

  system.activationScripts.postActivation.text = ''
    sudo --user=tamerlan -- mkdir -p /Users/tamerlan/Pictures/Screenshots
  '';

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      show-recents = false;
      mru-spaces = false;
      expose-group-apps = true;
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv";
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      NewWindowTarget = "Home";
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSWindowShouldDragOnGesture = true;
      "com.apple.swipescrolldirection" = true;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;

    LaunchServices.LSQuarantine = false;

    loginwindow.GuestEnabled = false;

    screencapture = {
      location = "/Users/tamerlan/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
    };

    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
    };
  };

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
