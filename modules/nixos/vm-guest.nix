{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.vm-guest.enable = lib.mkEnableOption "Enable VMware Fusion guest settings";

  config = lib.mkIf config.vm-guest.enable {
    virtualisation.vmware.guest.enable = true;

    networking.useDHCP = lib.mkDefault true;

    networking.firewall.enable = false;

    fileSystems."/host" = {
      fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
      device = ".host:/";
      options = [
        "umask=22"
        "uid=1000"
        "gid=1000"
        "allow_other"
        "auto_unmount"
        "defaults"
      ];
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "xrandr-auto" ''
        ${pkgs.xrandr}/bin/xrandr --output Virtual-1 --auto
      '')
    ];
  };
}
