# nixos

NixOS and nix-darwin configs for all my machines.

| Host      | Type                    | Notes                               |
| --------- | ----------------------- | ----------------------------------- |
| `t14`     | NixOS laptop            | GNOME, dev setup                    |
| `zx-1`    | NixOS desktop           | Gaming PC, Ollama, Jellyfin         |
| `prodesk` | NixOS server (headless) | Jellyfin, Open WebUI, uses disko    |
| `vm-dev`  | NixOS in OrbStack       | Dev container on the Mac            |
| `boyd`    | nix-darwin (MacBook)    | Config lives in `hosts/mac`         |

## Layout

- `flake.nix` - host list; `mkNixos` wires up `modules/nixos` and Home Manager
- `hosts/<host>/configuration.nix` - system config for a host
- `hosts/<host>/home.nix` - Home Manager config for a host
- `modules/nixos` - NixOS modules, toggled with `<name>.enable`
- `modules/home-manager` - Home Manager modules; `dev.enable` turns on the usual dev setup

### Where packages go

- **CLI tools** (jj, gh, lazygit, ripgrep, ...): `modules/home-manager/cli.nix`.
  Shared by every Home Manager host, Mac included. `dev.enable` turns it on.
- **System basics on NixOS** (vim, git, htop, ...): `modules/nixos/foundation.nix`.
  Also covers root and `prodesk`, which has no Home Manager.
- **Mac-only / not in nixpkgs for macOS** (GUI apps, `hunk`, ...): Homebrew in
  `hosts/mac/configuration.nix`.
- **One host only**: `home.packages` in `hosts/<host>/home.nix`.

## Applying changes

```sh
# NixOS (the hostname matches the flake name, so `#<host>` is optional)
sudo nixos-rebuild switch --flake ~/nixos#<host>

# Mac
sudo darwin-rebuild switch --flake ~/nixos#boyd
```

## Updating

```sh
nix flake update   # bump all inputs, then rebuild as above
sudo nix-collect-garbage --delete-older-than 15d
```

Garbage collection also runs weekly on the NixOS hosts.

## Adding a new NixOS host

1. Install NixOS from the [ISO](https://nixos.org/download/) and enable
   flakes plus `git` in `/etc/nixos/configuration.nix`, then
   `sudo nixos-rebuild switch`.
2. Clone this repo to `~/nixos`.
3. Create `hosts/<host>/`:
   - copy `/etc/nixos/hardware-configuration.nix` into it
   - add a `configuration.nix` (copy one from a similar host; keep
     `system.stateVersion` from the generated config)
   - add a `home.nix` with `home.stateVersion` and the modules you want
4. Add `<host> = mkNixos "<host>" { };` to `flake.nix` and `git add` the new files.
5. `sudo nixos-rebuild switch --flake ~/nixos#<host>`

## Mac (nix-darwin)

1. Install Nix (e.g. the [Determinate installer](https://determinate.systems/nix-installer/))
   and [Homebrew](https://brew.sh).
2. Clone this repo to `~/nixos`.
3. First run: `sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nixos#boyd`.
   After that, use `darwin-rebuild` as above.

GUI apps and a few CLIs come from Homebrew (see `hosts/mac/configuration.nix`).
Homebrew runs with `cleanup = "zap"`, so anything not listed there gets removed.

## vm-dev (OrbStack)

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

## prodesk (headless server)

Partitioning is declared with disko in `hosts/prodesk/disko.nix` (whole
`/dev/sda`: ESP, 8G swap, ext4 root). It's reachable over Tailscale and SSH
(key only, no root login).
