{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.ghostty.enable = lib.mkEnableOption "Enable Ghostty with custom config";

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;

      enableZshIntegration = true;
      settings = {
        theme = "Gruvbox Light";
      };
    };
  };
}
