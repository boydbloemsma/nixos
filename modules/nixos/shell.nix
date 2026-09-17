{ pkgs, config, ... }: {
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];
}
