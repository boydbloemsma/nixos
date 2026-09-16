{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "mptspi"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Set to "x86_64-linux" if the Mac host is Intel rather than Apple Silicon
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
