{ config, pkgs, ... }:

{
  home.username = "boyd";
  home.homeDirectory = "/home/boyd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings.user = {
      name = "Boyd Bloemsma";
      email = "boydbloemsma@gmail.com";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };

  ghostty.enable = true;
  code-dir.enable = true;
  neovim.enable = true;
  zed.enable = true;
  gnome-settings.enable = true;
  touchpad.enable = true;

  fish.enable = true;
  bash.enable = true;
  atuin.enable = true;
  direnv.enable = true;

  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
}
