{ config, lib, ... }:
{

  options = {
    zsh.enable = lib.mkEnableOption "Enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;

      shellAliases = {
        lg = "lazygit";
        ld = "lazydocker";
        nvim = "nix run github:boydbloemsma/neovim-flake";
      };

      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = [ "git" ];
      };
    };
  };
}
