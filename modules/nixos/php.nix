{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.php.enable = lib.mkEnableOption "Install PHP and PHPStorm";

  config = lib.mkIf config.php.enable {
    environment.systemPackages = with pkgs; [
      php85
      php85Packages.composer
      jetbrains.phpstorm
      laravel
    ];
  };
}
