{ config, lib, ... }: {
  options.keybindings.enable = lib.mkEnableOption "Add Gnome keybindings";

  config = lib.mkIf config.keybindings.enable {
    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = ["<Alt>Tab"];
        switch-windows-backwards = ["<Shift><Alt>Tab"];
        switch-applications = [];
        switch-applications-backwards = [];
      };
    };
  };
}
