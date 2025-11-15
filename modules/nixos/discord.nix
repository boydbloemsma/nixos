{ config, lib, pkgs, ... }: {
  options.discord.enable = lib.mkEnableOption "Install Discord";

  config = lib.mkIf config.discord.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
