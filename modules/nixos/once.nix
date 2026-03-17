{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.once.enable = lib.mkEnableOption "Install Once";

  config = lib.mkIf config.once.enable {
    environment.systemPackages = [
      (pkgs.callPackage ../../packages/once/package.nix { })
    ];
  };
}
