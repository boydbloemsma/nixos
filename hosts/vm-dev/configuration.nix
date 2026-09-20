{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    inputs.home-manager.nixosModules.default
    ./home-manager.nix
  ];

  networking.hostName = "vm-dev";

  system.stateVersion = "24.11";

  programs.fish.enable = true;

  users.users.boyd = {
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  vm-guest.enable = true;
  tailscale.enable = true;
  onepassword.enable = true;
  lazy.enable = true;
}
