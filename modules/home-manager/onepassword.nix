{
  config,
  lib,
  ...
}:
{
  options.onepassword.enable = lib.mkEnableOption "Enable 1password";

  config = lib.mkIf config.onepassword.enable {
    programs = {
      _1password.enable = true;

      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "boydbloemsma" ];
      };
    };
  };
}
