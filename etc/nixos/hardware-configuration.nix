# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/79292aca-93c9-4986-b9d6-2fc803dcf9c3";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."cryptroot0".device = "/dev/disk/by-uuid/c486a04b-8738-4c39-9cac-6d5f0fa0a5be";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/79292aca-93c9-4986-b9d6-2fc803dcf9c3";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/79292aca-93c9-4986-b9d6-2fc803dcf9c3";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/79292aca-93c9-4986-b9d6-2fc803dcf9c3";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/79292aca-93c9-4986-b9d6-2fc803dcf9c3";
      fsType = "btrfs";
      options = [ "subvol=log" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/22DD-AEBA";
      fsType = "vfat";
    };

  fileSystems."/mnt/store" =
    { device = "/dev/disk/by-uuid/532605bb-8955-472c-8cb0-245448610829";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."cryptstore".device = "/dev/disk/by-uuid/e7c8ffc3-82cb-46e5-afd3-d72d28732a2e";

  swapDevices = [ ];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
