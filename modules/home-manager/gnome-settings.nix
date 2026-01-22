{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.gnome-settings.enable = lib.mkEnableOption "Enable Gnome settings";

  config = lib.mkIf config.gnome-settings.enable {
    home.packages = with pkgs; [
      gnomeExtensions.appindicator
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        accent-color = "blue";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/lcd-rainbow-l.jxl";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/lcd-rainbow-d.jxl";
        picture-options = "zoom";
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backwards = [ "<Shift><Alt>Tab" ];
        switch-applications = [ ];
        switch-applications-backwards = [ ];
      };
    };
  };
}
