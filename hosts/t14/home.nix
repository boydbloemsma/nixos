{ pkgs, ... }:
{
  # Never change this after the first install.
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    github-desktop
  ];

  dev.enable = true;

  ghostty.enable = true;
  zed.enable = true;
  gnome-settings.enable = true;
  touchpad.enable = true;
}
