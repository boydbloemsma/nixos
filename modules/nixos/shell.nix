{ pkgs, config, lib, ... }: {
  options.shell.enable = lib.mkEnableOption "Set fish as the default shell";

  config = lib.mkIf config.shell.enable {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
    environment.shells = with pkgs; [ fish ];
  };
}
