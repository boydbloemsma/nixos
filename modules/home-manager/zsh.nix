{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;

    shellAliases = {
      lg = "lazygit";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
  };
}
