{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "zx-1";

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
  ai.ollama.enable = true;
  kamal.enable = true;
  onepassword.enable = true;
  tailscale.enable = true;
  gaming.enable = true;
  media.enable = true;
  media.jellyfin.enable = true;
  media.jellyfin.user = "boyd";
}
