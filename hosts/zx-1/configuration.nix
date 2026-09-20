{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./home-manager.nix
  ];

  networking.hostName = "ZX-1";

  system.stateVersion = "24.11";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  services.thermald.enable = true;
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  desktop-base.docker = false;
  desktop-base.nix-ld = false;
  lazy.enable = true;
  ai.enable = true;
  kamal.enable = true;
  onepassword.enable = true;
  tailscale.enable = true;
  gaming.enable = true;
  media.enable = true;
}
