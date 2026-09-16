{
  config,
  lib,
  inputs,
  ...
}:
{

  options = {
    fish.enable = lib.mkEnableOption "Enables fish";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;

      shellAliases = import ./shell-aliases.nix;

      functions = {
        fish_greeting = "";
      };

      plugins = [
        {
          name = "theme-bobthefish";
          src = inputs.theme-bobthefish;
        }
      ];
    };
  };
}
