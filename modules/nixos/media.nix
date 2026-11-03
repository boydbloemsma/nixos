{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.media = {
    enable = lib.mkEnableOption "Install VLC, qbittorrent, Proton VPN and RawTherapee";
    jellyfin = {
      enable = lib.mkEnableOption "Run a Jellyfin server";
      user = lib.mkOption {
        type = lib.types.str;
        default = "jellyfin";
        description = "User the Jellyfin service runs as.";
      };
    };
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
        user = config.media.jellyfin.user;
      };
    })
  ];
}
