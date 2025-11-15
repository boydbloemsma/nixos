{ config, lib, pkgs, ... }: {
  options.media.enable = lib.mkEnableOption "Install VLC, Plex, qbittorrent and Proton VPN";

  config = lib.mkIf config.media.enable {
    environment.systemPackages = with pkgs; [
      vlc
      plex
      qbittorrent
      protonvpn-gui
    ];
  };
}
