{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.media = {
    enable = lib.mkEnableOption "Install VLC, qbittorrent, Proton VPN and RawTherapee";
    jellyfin.enable = lib.mkEnableOption "Run a Jellyfin server";
  };

  config = lib.mkMerge [
    (lib.mkIf config.media.enable {
      environment.systemPackages = with pkgs; [
        vlc
        qbittorrent
        proton-vpn
        rawtherapee
      ];
    })

    (lib.mkIf config.media.jellyfin.enable {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
      };
    })
  ];
}
