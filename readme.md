# NixOS Notes

## Some Exposition

Rather than having `configuration.nix` and `hardware-configuration.nix` files in the `/etc/nixos/` folder, the entire NixOS configuration is managed via a Flake which makes it easy to define multiple machine configurations which can all share a common base. Since configuration is managed via a flake, the configuration files can all be owned by a user in their home folder rather than being in a system folder.

Home Manager is used to manage config files.

The combination of using a flake and Home Manager means that it is very easy to store the configurations of all of the computers and all of the applications used in a single Git repository and there is no need to manage symlinks or use a bare repository which are the usual approaches to storing config files in Git.

## File & Folder Structures

The `flake.nix` file defines the Nix packages URL and Home Manager URL along with the user account name and the location of the configuration files. For its configuration it imports the contents of the `hosts/default.nix` file.

The `hosts/default.nix` file sets up the configurations used for each computer. Each configuration then references both 'core' and per-computer modules; one each for NixOS itself and for Home Manager. For example, my `desktop` configuration uses the `hosts/configuration.nix` NixOS confiuration file which is common across all computers and the `hosts/desktop/default.nix` NixOS configuration file which is specific to the `desktop` computer. It also uses the `hosts/home.nix` Home Manager configuration file which is common across all computers and the `hosts/desktop/home.nix` Home Manager configuration file which is specific to the `desktop` computer.

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
