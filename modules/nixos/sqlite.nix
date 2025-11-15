{ config, lib, pkgs, ... }: {
  options.sqlite.enable = lib.mkEnableOption "Install sqlite";

  config = lib.mkIf config.sqlite.enable {
    environment.systemPackages = with pkgs; [
      sqlite
    ];
  };
}
