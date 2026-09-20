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

  networking.hostName = "T480";

  system.stateVersion = "24.11";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  services.thermald.enable = true;
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";

  onepassword.enable = true;
  tailscale.enable = true;
  lazy.enable = true;
  ai.enable = true;
  kamal.enable = true;
}
