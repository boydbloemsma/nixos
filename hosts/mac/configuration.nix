{ pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  system.primaryUser = "ede-mac048";
  users.users.ede-mac048.home = "/Users/ede-mac048";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [ git ];
  
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };
    brews = [
      "node"
      "mkcert"
      "nss"
    ];
    casks = [
      "ghostty" 
      "orbstack" 
      "1password" 
      "firefox" 
      "slack"
      "microsoft-teams"
      "claude-code"
      "codex"
      "openvpn-connect"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults.dock.autohide = true;
}
