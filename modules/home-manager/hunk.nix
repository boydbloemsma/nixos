{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.hunk.enable = lib.mkEnableOption "Hunk diff viewer";

  config = lib.mkIf config.hunk.enable {
    home.packages = lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.hunk;

    xdg.configFile."hunk/config.toml".text = ''
      mode = "unified"
      agent_notes = true
      theme = "gruvbox-dark"
      line_numbers = true
      wrap_lines = true
    '';
  };
}
