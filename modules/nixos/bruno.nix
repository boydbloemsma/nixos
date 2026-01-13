{ config, lib, pkgs, ... }: {
  options.httpie.enable = lib.mkEnableOption "Install Bruno";

  config = lib.mkIf config.httpie.enable {
    environment.systemPackages = with pkgs; [
      bruno
      bruno-cli
    ];
  };
}
