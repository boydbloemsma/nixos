{ pkgs, ... }: {
  home.username = "ede-mac048";
  home.homeDirectory = "/Users/ede-mac048";
  home.stateVersion = "25.11";

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

  code-dir.enable = true;
  neovim.enable = true;

  fish.enable = true;
  bash.enable = true;
  atuin.enable = true;
  direnv.enable = true;
  hunk.enable = true;

  ghostty.enable = true;
  programs.ghostty.package = null;

  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
}
