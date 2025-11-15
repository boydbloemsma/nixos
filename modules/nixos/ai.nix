{ config, lib, pkgs, ... }: {
  options.ai.enable = lib.mkEnableOption "Install Claude Code";

  config = lib.mkIf config.ai.enable {
    environment.systemPackages = with pkgs; [
      claude-code
    ];
  };
}
