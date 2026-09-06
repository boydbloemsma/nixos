{
  config,
  lib,
  ...
}:
{
  options.tailscale.enable = lib.mkEnableOption "Enable Tailscale";

  config = lib.mkIf config.tailscale.enable {
    services.tailscale.enable = true;

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.firewall.checkReversePath = "loose";
  };
}
