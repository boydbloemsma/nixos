# Installing

When adding a new host you will need to generate a new host.nix file.
The following command copies it to `/etc/nixos/` change this to the new host location

```sh
nix run home-manager/master -- init && \
sudo cp ~/.config/home-manager/home.nix /etc/nixos/
```

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
