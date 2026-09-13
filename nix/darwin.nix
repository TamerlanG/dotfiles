{
  inputs,
  pkgs,
  user,
  ...
}:

let
  home = "/Users/${user}";
in

{
  environment.systemPackages = with pkgs; [
    aerospace
    fish
    betterdisplay
    desktoppr
    orbstack
    btop
  ];

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 3;
      Minute = 0;
    };
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.users.${user} = {
    inherit home;
    shell = pkgs.fish;
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  system.stateVersion = 6;
  system.primaryUser = user;

  system.activationScripts.postActivation.text = ''
    sudo --user=${user} -- mkdir -p ${home}/Pictures/Screenshots
    # Activation runs as root outside the Aqua session; asuser targets the user's GUI session.
    # Non-fatal: no GUI session (SSH, pre-login) must not abort the generation switch.
    launchctl asuser "$(id -u ${user})" sudo --user=${user} -- \
      ${pkgs.desktoppr}/bin/desktoppr all ${home}/.dotfiles/wallpapers/main.jpg \
      || echo "warning: wallpaper not applied (no GUI session?)" >&2
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
      location = "${home}/Pictures/Screenshots";
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
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  homebrew = {
    enable = true;

    # Deterministic switches: brew update/upgrade only via `make update-brew`.
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    brews = [
      "omp"
      "mole"
      "herdr"
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
      "okta-verify"
      "handy"
      "hiddenbar"
    ];
  };
}
