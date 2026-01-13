{ config, lib, pkgs, ... }: {
  options.bruno.enable = lib.mkEnableOption "Install Bruno";

  config = lib.mkIf config.bruno.enable {
    environment.systemPackages = with pkgs; [
      bruno
      bruno-cli
    ];
  };
}
