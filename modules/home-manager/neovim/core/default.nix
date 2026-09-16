{ pkgs, lib, ... }: {
    imports = [
        ./options.nix
        ./theme.nix
        ./remap.nix
    ];
}
