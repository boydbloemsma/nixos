{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.foundation.enable = lib.mkEnableOption "Minimal system tools for every NixOS host";

  config = lib.mkIf config.foundation.enable {
    environment.systemPackages = with pkgs; [
      vim
      neovim
      git
      wget
      jq
      ripgrep
      htop
      tree
    ];
  };
}
