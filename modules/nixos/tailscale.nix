{
  config,
  lib,
  ...
}:
let
  cfg = config.tailscale;
  isRouter = cfg.advertiseRoutes != [ ];
in
{
  options.tailscale = {
    enable = lib.mkEnableOption "Enable Tailscale";
    advertiseRoutes = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "192.168.1.110/32" ];
      description = "LAN subnets this host exposes to the tailnet (subnet router). Approve them in the admin console.";
    };
    acceptRoutes = lib.mkOption {
      type = lib.types.bool;
      default = !isRouter;
      description = "Use subnet routes advertised by other nodes. Disable on machines that are always on the home LAN.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if isRouter then "server" else "client";
      # Set both explicitly so turning an option off also clears it in tailscaled.
      extraSetFlags = [
        "--advertise-routes=${lib.concatStringsSep "," cfg.advertiseRoutes}"
        "--accept-routes=${lib.boolToString cfg.acceptRoutes}"
      ];
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.firewall.checkReversePath = "loose";
  };
}
