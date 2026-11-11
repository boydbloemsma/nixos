{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.cli.enable = lib.mkEnableOption "Dev CLI tools (jj, gh, lazygit, ...), shared by NixOS and macOS";

  config = lib.mkIf config.cli.enable {
    home.packages = with pkgs; [
      lazygit
      lazydocker
      gh
      just
      devenv
      lf
      ripgrep
      fd
      fzf
      bat
      eza
      jq
      wget
      htop
      tree
    ];

    hunk.enable = lib.mkDefault true;
  };
}
