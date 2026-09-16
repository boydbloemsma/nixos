{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.foundation.enable = lib.mkEnableOption "Install foundational packages";

  config = lib.mkIf config.foundation.enable {
    environment.systemPackages = with pkgs; [
      vim
      git
      jujutsu
      neovim
      lf
      wget
      just
      gh
      jq
      ripgrep
      fd
      fzf
      bat
      eza
      htop
      tree
    ];
  };
}
