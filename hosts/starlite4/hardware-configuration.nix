# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      #device = "/dev/disk/by-uuid/d1a0cabb-636f-453d-8f5f-d36a30139499";
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      #device = "/dev/disk/by-uuid/4B3D-04D3";
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [
      {
        #device = "/dev/disk/by-uuid/b87ad60b-b1e3-4b9c-9d55-2c9cf6950dba";
        device = "/dev/disk/by-label/swap";
      }
    ];

  networking = {
    useDHCP = false;
    hostName = "starlite4";
    networkmanager.enable = true;
    interfaces = {
      wlp0s12f0 = {
        useDHCP = true;
      };
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

