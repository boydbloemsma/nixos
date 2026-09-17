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

  ghostty.enable = true;
  code-dir.enable = true;
  neovim.enable = true;
  zed.enable = true;
  gnome-settings.enable = true;

  fish.enable = true;
  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
}
