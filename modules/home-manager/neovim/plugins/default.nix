{ pkgs, lib, ... }: {
    imports = [
        ./telescope.nix
        ./lualine.nix
        ./gitsigns.nix
        ./lsp.nix
        ./coding.nix
        ./lazygit.nix
        ./mini.nix
        ./conform.nix
        ./undotree.nix
    ];
}
