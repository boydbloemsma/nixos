{
  config,
  lib,
  ...
}:
{

  options = {
    bash.enable = lib.mkEnableOption "Enables bash";
  };

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      enable = true;

      shellAliases = import ./shell-aliases.nix;
    };
  };
}
