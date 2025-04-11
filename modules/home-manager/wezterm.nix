{ config, lib, pkgs, ... }: {
  options.my.wezterm.enable = lib.mkEnableOption "Enable WezTerm with custom config";

  config = lib.mkIf config.my.wezterm.enable {
    programs.wezterm = {
      enable = true;

      extraConfig = ''
        return {
	  enable_tab_bar = false,
	  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	  color_scheme = 'Gruvbox light, medium (base16)',
	};
      '';
    };
  };
}
