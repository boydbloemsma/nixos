{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "prodesk";

  # Set to the NixOS release you install with; never change it afterwards.
  system.stateVersion = "26.11";

  users.users.boyd.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEs13tZtTaM/BOge6jCr5hUdzVpzYlyMRblzZhvy97mN boydbloemsma@gmail.com"
  ];
  security.sudo.wheelNeedsPassword = false;

  desktop-base.enable = false;
  server-base.enable = true;

  tailscale.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # VA-API/QSV (iHD)
    ];
  };
  hardware.enableRedistributableFirmware = true;

  media.jellyfin.enable = true;
  services.jellyfin = {
    hardwareAcceleration = {
      enable = true;
      type = "qsv";
      device = "/dev/dri/renderD128";
    };
    transcoding = {
      enableHardwareEncoding = true;
      enableToneMapping = false;
      enableIntelLowPowerEncoding = false;
      hardwareDecodingCodecs = {
        h264 = true;
        hevc = true;
        hevc10bit = true;
        mpeg2 = true;
        vc1 = true;
        vp8 = true;
        vp9 = true;
        # No AV1 decode on this iGPU.
      };
      hardwareEncodingCodecs.hevc = true;
    };
  };
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ];

  # Uncomment once the NAS is set up; fill in its IP and export path.
  # fileSystems."/mnt/media" = {
  #   device = "192.168.1.x:/volume/media";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "noauto"
  #     "_netdev"
  #     "x-systemd.idle-timeout=600"
  #   ];
  # };

  ai.open-webui = {
    enable = true;
    ollamaUrl = "http://zx-1:11434"; # MagicDNS
  };
}
