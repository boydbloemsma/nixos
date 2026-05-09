{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.media.enable = lib.mkEnableOption "Install VLC, Jellyfin, qbittorrent and Proton VPN";

  config = lib.mkIf config.media.enable {
    environment.systemPackages = with pkgs; [
      vlc
      qbittorrent
      proton-vpn
      rawtherapee
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = "boyd";
    };
  };
}
