{ config, lib, ... }: {

    options = {
        my.zsh.enable = lib.mkEnableOption "Enables zsh";
    };

    config = lib.mkIf config.my.zsh.enable {
        programs.zsh = {
            enable = true;

            shellAliases = {
                lg = "lazygit";
                nvim = "nix run github:boydbloemsma/neovim-flake";
            };

            oh-my-zsh = {
                enable = true;
                theme = "robbyrussell";
                plugins = [ "git" ];
            };
        };
    };
}
