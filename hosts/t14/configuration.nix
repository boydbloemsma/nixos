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

  networking.hostName = "T14";

  system.stateVersion = "26.05";

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
  ai.enable = true;
  lazy.enable = true;
  kamal.enable = true;
}
