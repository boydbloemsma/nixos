{ config, lib, ... }:
{
  options.atuin.enable = lib.mkEnableOption "Enables atuin";

  config = lib.mkIf config.atuin.enable {
    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
