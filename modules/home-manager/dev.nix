{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.dev.enable = lib.mkEnableOption "Dev environment (git, fish, neovim, direnv, ...)";

  config = lib.mkIf config.dev.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Boyd Bloemsma";
        email = "boydbloemsma@gmail.com";
      };
    };

    programs.jujutsu = {
      enable = true;
      settings.user = config.programs.git.settings.user;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.fish}/bin/fish";
    };

    cli.enable = lib.mkDefault true;
    code-dir.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    bash.enable = lib.mkDefault true;
    atuin.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
  };
}
