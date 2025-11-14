# Installing



# Updating

What to do when updating nix

## Packages

If you change the configuration run this

```sh
sudo nixos-rebuild switch --flake ~/nixos/#nixos
```

## OS

Run the following in the nixos directory if you want to update to a newer NixOS version

```sh
sudo nix flake update
```
