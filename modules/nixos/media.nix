{ config, lib, pkgs, ... }: {
  options.media.enable = lib.mkEnableOption "Install VLC, Plex, qbittorrent and Proton VPN";

  config = lib.mkIf config.media.enable {
    environment.systemPackages = with pkgs; [
      vlc
      qbittorrent
      protonvpn-gui
      rawtherapee
    ];

        # services.plex = {
        # enable = true;
        # openFirewall = true;
        # user = "boyd";
        # group = "users";
        # };
  };
}
