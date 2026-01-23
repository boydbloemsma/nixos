{ pkgs, lib, ... }:
{
  imports = [
    ./structure.nix
    ./ghostty.nix
    ./zed.nix
    ./zsh.nix
    ./gnome-settings.nix
    ./touchpad.nix
  ];
}
