{ lib, ... }:
{
  imports = [
    ./common.nix
    ./shell.nix
    ./foundation.nix
    ./desktop-base.nix
    ./server-base.nix
    ./ai.nix
    ./kamal.nix
    ./media.nix
    ./gaming.nix
    ./onepassword.nix
    ./tailscale.nix
  ];

  common.enable = lib.mkDefault true;
  foundation.enable = lib.mkDefault true;
  desktop-base.enable = lib.mkDefault true;
  shell.enable = lib.mkDefault true;
}
