{ config, lib, pkgs, ... }: {
  options.node.enable = lib.mkEnableOption "Install node";

  config = lib.mkIf config.node.enable {
    environment.systemPackages = with pkgs; [
      nodejs_22
      pnpm
    ];
  };
}
