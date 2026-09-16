{ config, lib, ... }:
{
  options.neovim.enable = lib.mkEnableOption "Neovim configured with nvf";

  config = lib.mkIf config.neovim.enable {
    programs.nvf = {
      enable = true;
      settings.imports = [ ./neovim ];
    };
  };
}
