{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.gaming.enable = lib.mkEnableOption "Install gaming setup";

  config = lib.mkIf config.gaming.enable {
    # Improves gaming capabilities
    programs.gamemode.enable = true;

    # Install Steam
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      discord
      chromium
    ];
  };
}
