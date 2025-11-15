{ config, lib, pkgs, ... }: {
  options.lazy.enable = lib.mkEnableOption "Install lazygit and lazydocker";

  config = lib.mkIf config.lazy.enable {
    environment.systemPackages = with pkgs; [
      lazygit
      lazydocker
    ];
  };
}
