# NixOS Notes

## Fresh Install

* Boot into ISO
* `sudo su`
* `nix-env -iA nixos.git`
* `git clone <repo_url> /mnt/<path>
* `nixos-install --flake .#<host>`
* Reboot
* Login
* `sudo rm -r /etc/nixos/configuration.nix`

> Probably clone into `/mnt/etc/nixos/`

## Updating

```bash
nix flake update
sudo nixos-rebuild switch --flake .#simon-lite2
```
