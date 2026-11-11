{ config, lib, ... }:
{
  options.server-base.enable = lib.mkEnableOption "Headless server base (no desktop)";

  config = lib.mkIf config.server-base.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    users.users.boyd = {
      isNormalUser = true;
      description = "Boyd Bloemsma";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    # Fallback for when Tailscale is down; Tailscale SSH works too.
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Always-on box: never suspend.
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
  };
}
