{ inputs, lib, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./structure.nix
    ./ghostty.nix
    ./zed.nix
    ./neovim.nix
    ./fish.nix
    ./bash.nix
    ./atuin.nix
    ./gnome-settings.nix
    ./touchpad.nix
    ./direnv.nix
    ./hunk.nix
    ./cli.nix
    ./dev.nix
  ];

  programs.home-manager.enable = lib.mkDefault true;
}
