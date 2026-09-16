{ pkgs, lib, ... }:
{
  imports = [
    ./structure.nix
    ./ghostty.nix
    ./zed.nix
    ./fish.nix
    ./bash.nix
    ./atuin.nix
    ./gnome-settings.nix
    ./touchpad.nix
  ];
}
