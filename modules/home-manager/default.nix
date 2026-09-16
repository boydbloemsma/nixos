{ pkgs, lib, ... }:
{
  imports = [
    ./structure.nix
    ./ghostty.nix
    ./zed.nix
    ./fish.nix
    ./bash.nix
    ./gnome-settings.nix
    ./touchpad.nix
  ];
}
