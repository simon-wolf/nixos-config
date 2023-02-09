# NixOS Notes

## Some Exposition

Rather than having `configuration.nix` and `hardware-configuration.nix` files in the `/etc/nixos/` folder, the entire NixOS configuration is managed via a Flake which makes it easy to define multiple machine configurations which can all share a common base. Since configuration is managed via a flake, the configuration files can all be owned by a user in their home folder rather than being in a system folder.

Home Manager is used to manage config files, either by generating them or creating symlinks to existing files.

The combination of using a flake and Home Manager means that it is very easy to store the configurations of all of the computers and all of the applications used in a single Git repository. There is no need to manually create symlinks or use a bare repository which are the usual approaches to storing config files in Git.

## File & Folder Structures

### NixOS & Home Manager

The `flake.nix` file defines the Nix packages URL and Home Manager URL along with the user account name and the location of the configuration files. For its configuration it imports the contents of the `hosts/default.nix` file.

The `hosts/default.nix` file sets up the configurations used for each computer. Each configuration then references both 'core' and per-computer modules; one each for NixOS itself and for Home Manager. For example, my `desktop` configuration uses the `hosts/configuration.nix` NixOS configuration file which is common across all computers and the `hosts/desktop/default.nix` NixOS configuration file which is specific to the `desktop` computer. It also uses the `hosts/home.nix` Home Manager configuration file which is common across all computers and the `hosts/desktop/home.nix` Home Manager configuration file which is specific to the `desktop` computer.

### Modules

The `modules` folder allows us to create 'profiles' which can be imported by the main configuration files.

For example, there is a `shell` module which contains configuration files for Git and Zsh. A `shell/default.nix` file references those files so that our shell profile includes both Git and Zsh configs but allows us to keep the configs in their own files.

Similarly a `desktop/sway/sway.nix` file allows us to store a configuration for the Sway window manager separately from, say, a Gnome configuration and it contains everything needed to run Sway.

### Config

The `config` folder contains configuration files that have not been migrated over to Home Manager. Home Manager simply creates symlinks to specified locations so that the applications can then reference these configuration files. This allows the originals to be stored in this repository. 

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

## WiFi Config

### Enable WiFi

To list network devices:

`nmcli dev status`

To just see if wifi is enabled:

`nmcli radio wifi`

If wifi is disabled it can be enabled with:

`nmcli radio wifi on`

### List Wifi Networks

`nmcli dev wifi list`

### Connect to Wifi

`sudo nmcli dev wifi connect [network-ssid]`

You will be prompted for the password or you can enter it at the same time via:

`sudo nmcli dev wifi connect [network-ssid] password [network-password]`

Or if you want to be prompted for the password:

`sudo nmcli --ask dev wifi connect [network-ssid]`

### Check Configured Networks

You can view the configured networks via:

`nmcli con show`

### Connecting and Disconnecting

To disconnect from a network:

`nmclt con down [ssid]`

To connect to a network:

`nmcli con up [ssid]`

## Nix-Shell

...

## To Do

### nix-shell and Elixir

* http://ghedam.at/15978/an-introduction-to-nix-shell
* https://ghedam.at/15443/a-nix-shell-for-developing-elixir
* https://til.codes/nix-shell-for-elixir-projects/

### Other

* https://unix.stackexchange.com/a/218050
* https://computingforgeeks.com/setup-sway-tiling-window-manager-on-fedora-with-waybar/
* https://fedingo.com/how-to-connect-to-wifi-using-nmcli/
* https://github.com/wamserma/nixos-check-update
* https://ianthehenry.com/posts/how-to-learn-nix/introduction/
