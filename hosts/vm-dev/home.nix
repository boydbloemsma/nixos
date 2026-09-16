{ config, pkgs, ... }: {
  home.username = "boyd";
  home.homeDirectory = "/home/boyd";
  home.stateVersion = "24.05";

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

  nixpkgs.config.allowUnfree = true;

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

  fish.enable = true;
  bash.enable = true;
  atuin.enable = true;

  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
}
