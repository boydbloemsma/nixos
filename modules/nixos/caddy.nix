{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.caddy-proxy;
in
{
  options.caddy-proxy = {
    enable = lib.mkEnableOption "Caddy reverse proxy with Porkbun DNS-01 certificates";

    domain = lib.mkOption {
      type = lib.types.str;
      example = "example.com";
      description = "Base domain; services are served as <name>.<domain>.";
    };

    hosts = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = {
        chat = "127.0.0.1:8080";
      };
      description = "Subdomain -> upstream address.";
    };

    environmentFile = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/caddy/porkbun.env";
      description = ''
        File (not in the Nix store) containing
        PORKBUN_API_KEY=... and PORKBUN_API_SECRET_KEY=...
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/porkbun@v0.3.1" ];
        hash = "sha256-Nu2vsmjS5Lz6Wh99cGN1FUNX3hymM/sesRyCeDVfrvM=";
      };

      # DNS-01: certs are issued without exposing ports 80/443 to the internet.
      globalConfig = ''
        acme_dns porkbun {
          api_key {env.PORKBUN_API_KEY}
          api_secret_key {env.PORKBUN_API_SECRET_KEY}
        }
      '';

      # One wildcard site => one *.domain certificate, so individual subdomain
      # names don't show up in public Certificate Transparency logs.
      virtualHosts."*.${cfg.domain}".extraConfig = ''
        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: upstream: ''
            @${name} host ${name}.${cfg.domain}
            handle @${name} {
              reverse_proxy ${upstream}
            }
          '') cfg.hosts
        )}

        handle {
          abort
        }
      '';
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = cfg.environmentFile;

    # No public firewall holes: tailscale0 is already a trusted interface,
    # so 80/443 are reachable over the tailnet only.
  };
}
