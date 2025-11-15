{ config, lib, pkgs, ... }: {
  options.kamal.enable = lib.mkEnableOption "Install Kamal";

  config = lib.mkIf config.kamal.enable {
    environment.systemPackages = with pkgs; [
      kamal
    ];
  };
}
