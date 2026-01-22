{ lib, ... }:
{
  imports = [
    ./shell.nix
    ./foundation.nix
    ./bruno.nix
    ./lazy.nix
    ./php.nix
    ./sqlite.nix
    ./node.nix
    ./ai.nix
    ./kamal.nix
    ./media.nix
    ./gaming.nix
  ];

  foundation.enable = lib.mkDefault true;
}
