{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  system.primaryUser = "ede-mac048";
  users.users.ede-mac048.home = "/Users/ede-mac048";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ git ];
  environment.shells = [ pkgs.fish ];
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [
      "node"
      "mkcert"
      "nss"
      "herdr"
      "pi-coding-agent"
      "hunk"
    ];
    casks = [
      "ghostty"
      "orbstack"
      "1password"
      "firefox"
      "slack"
      "microsoft-teams"
      "openvpn-connect"
      "datagrip"
      "bruno"
      "codex"
      "claude-code"
      "signal"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
      tilesize = 48;

      persistent-apps = [
        "/Applications/OpenVPN Connect/OpenVPN Connect.app/"
        "/Applications/OrbStack.app/"
        "/Applications/1Password.app/"
        "/System/Applications/Calendar.app/"
        "/Applications/Microsoft Teams.app/"
        "/System/Applications/Mail.app/"
        "/Applications/Slack.app/"
        "/Applications/DataGrip.app/"
        "/Applications/Ghostty.app/"
        "/System/Cryptexes/App/System/Applications/Safari.app/"
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
    };

    trackpad.Clicking = true;
    screencapture.location = "~/Pictures/Screenshots";
  };

  programs.fish.enable = true;
}
