{
  # Never change this after the first install.
  home.stateVersion = "25.11";

  dev.enable = true;
  hunk.enable = true;

  # Ghostty is installed through Homebrew; only manage its config.
  ghostty.enable = true;
  programs.ghostty.package = null;
}
