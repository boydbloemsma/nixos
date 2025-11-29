{ pkgs, lib, ... }: {
  imports = [
    ./structure.nix
    ./wezterm.nix
    ./zed.nix
    ./zsh.nix
    ./gnome-settings.nix
  ];
}
