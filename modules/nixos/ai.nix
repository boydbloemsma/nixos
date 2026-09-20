{ config, lib, pkgs, inputs, ... }: {
  options.ai.enable = lib.mkEnableOption "Install AI tools";

  config = lib.mkIf config.ai.enable {
    environment.systemPackages = with pkgs; [
      inputs.llm-agents-nix.packages.${pkgs.stdenv.hostPlatform.system}.herdr
      inputs.llm-agents-nix.packages.${pkgs.stdenv.hostPlatform.system}.pi
      inputs.llm-agents-nix.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    ];
  };
}
