# Installing

When adding a new host you will need to generate a new host.nix file.
The following command copies it to `/etc/nixos/` change this to the new host location.

```sh
nix run home-manager/master -- init && \
sudo cp ~/.config/home-manager/home.nix /etc/nixos/
```

You can now use this host.nix file in a new host directory.

## Installing the OS on a new host

First download the NixOS ISO from [here](https://nixos.org/download/) and flash it to a usb drive.

> hint: if you are using linux you can use `dd`

Then the easiest thing to do is to install `git` and `vim` so you can clone the repo and edit things.
Do this by adding them to the `systemPackages` in `/etc/nixos/configuration.nix` and running the following command.

```sh
sudo nixos-rebuild switch
```

Now you can create a backup of the current NixOS config in case something goes wrong,
and because we will need the hardware-configuration.nix

```sh
sudo cp -r /etc/nixos ~/nixos-backup
```

When this is done we can remove the current NixOS config.

```sh
sudo rm -rf /etc/nixos
```

> hint: You might need to change the ownership before you can remove it `sudo chown -R boyd:users /etc/nixos`

Now clone the repo to `/etc/nixos`

And finally install for the host you want.

```sh
sudo nixos-rebuild switch --flake /etc/nixos/#zx-1
```

When this is done you can move it anywhere since we use home manager.
Like the user directory: `~/nixos`

## Installing on a MacBook with OrbStack

`vm-dev` runs as an OrbStack NixOS machine (an LXC container), so there's no
bootloader, disk partitioning or hardware config. OrbStack handles networking,
SSH (`ssh vm-dev@orb`) and mounts your Mac home at `/Users/<you>`.

1. On the Mac, create the machine and open a shell in it:

   ```sh
   orb create nixos vm-dev
   orb -m vm-dev
   ```

2. Clone this repo inside the machine, then copy OrbStack's generated modules in:

   ```sh
   cp /etc/nixos/orbstack.nix /etc/nixos/incus.nix ~/nixos/hosts/vm-dev/
   git -C ~/nixos add hosts/vm-dev
   ```

   (Older images generate `lxd.nix` instead of `incus.nix`; update the import
   in `hosts/vm-dev/configuration.nix` if so.) Match `system.stateVersion` and
   the user's `uid` to OrbStack's generated `/etc/nixos/configuration.nix`.

3. Apply the config:

   ```sh
   sudo nixos-rebuild switch --flake ~/nixos#vm-dev
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

Remove stale versions of the OS using the following command

```sh
sudo nix-collect-garbage --delete-older-than 15d
```
