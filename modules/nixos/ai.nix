{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.ai;
  agents = inputs.llm-agents-nix.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.ai = {
    enable = lib.mkEnableOption "Install AI CLI tools";

    ollama.enable = lib.mkEnableOption "Ollama server with CUDA";

    open-webui = {
      enable = lib.mkEnableOption "Open WebUI";
      ollamaUrl = lib.mkOption {
        type = lib.types.str;
        default = "http://127.0.0.1:11434";
        description = "Ollama endpoint Open WebUI connects to.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.systemPackages = [
        agents.herdr
        agents.pi
        agents.claude-code
      ];
    })

    (lib.mkIf cfg.ollama.enable {
      services.ollama = {
        enable = true;
        package = pkgs.ollama-cuda;
        # Reachable over tailscale0 (trusted interface); the LAN stays firewalled.
        host = "0.0.0.0";
        loadModels = [ "qwen3:8b" ];
        environmentVariables = {
          OLLAMA_KEEP_ALIVE = "5m"; # free VRAM for games
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q8_0";
        };
      };
    })

    (lib.mkIf cfg.open-webui.enable {
      services.open-webui = {
        enable = true;
        environment = {
          OLLAMA_BASE_URL = cfg.open-webui.ollamaUrl;
          AIOHTTP_CLIENT_TIMEOUT_MODEL_LIST = "3";
          SCARF_NO_ANALYTICS = "True";
          DO_NOT_TRACK = "True";
          ANONYMIZED_TELEMETRY = "True";
        };
      };
    })
  ];
}
