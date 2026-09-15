{ pkgs, lib, ... }:
{
  imports = [
    ./structure.nix
    ./ghostty.nix
    ./zed.nix
    ./fish.nix
    ./gnome-settings.nix
    ./touchpad.nix
  ];
}
