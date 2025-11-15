{ config, lib, pkgs, ... }: {
    options.httpie.enable = lib.mkEnableOption "Install HTTPie";

    config = lib.mkIf config.httpie.enable {
      environment.systemPackages = with pkgs; [
        httpie
        httpie-desktop
      ];
    };
}
