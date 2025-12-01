{ config, lib, ... }: {
  options.touchpad.enable = lib.mkEnableOption "Enable touchpad settings";

  config = lib.mkIf config.touchpad.enable {
    dconf.settings = {
      "org/gnome/desktop/peripherals/touchpad" = {
        click-method = "areas";
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };
    };
  };
}
