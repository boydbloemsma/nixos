{ config, lib, ... }:
{
  options.hunk.enable = lib.mkEnableOption "Hunk diff viewer config";

  # Only manages the config; the binary comes from foundation.nix on NixOS
  # and from Homebrew on macOS (nixpkgs' hunk is Linux-only).
  config = lib.mkIf config.hunk.enable {
    xdg.configFile."hunk/config.toml".text = ''
      mode = "split"
      theme = "gruvbox-dark"
      line_numbers = true
      wrap_lines = true
    '';
  };
}
