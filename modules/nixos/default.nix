{ lib, ... }:
{
  imports = [
    ./shell.nix
    ./foundation.nix
    ./lazy.nix
    ./ai.nix
    ./kamal.nix
    ./media.nix
    ./gaming.nix
    ./onepassword.nix
    ./tailscale.nix
    ./vm-guest.nix
  ];

  foundation.enable = lib.mkDefault true;
}
