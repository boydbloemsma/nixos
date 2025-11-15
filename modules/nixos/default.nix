{ pkgs, lib, ... }: {
  imports = [
    ./shell.nix
    ./foundation.nix
    ./httpie.nix
    ./lazy.nix
    ./php.nix
    ./sqlite.nix
    ./node.nix
    ./ai.nix
    ./kamal.nix
    ./media.nix
    ./discord
  ];

  foundation.enable = lib.mkDefault true;
}
