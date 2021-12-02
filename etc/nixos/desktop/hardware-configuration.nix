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
    { device = "/dev/disk/by-uuid/3ce830cd-747f-4c86-84b8-4105a74a9f34";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/f681190a-9012-4fef-acef-17c2626247da";

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/3ce830cd-747f-4c86-84b8-4105a74a9f34";
      fsType = "btrfs";
      options = [ "subvol=@var_log" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C2DC-650A";
      fsType = "vfat";
    };

  fileSystems."/.snapshots" =
    { device = "/dev/disk/by-uuid/3ce830cd-747f-4c86-84b8-4105a74a9f34";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/3ce830cd-747f-4c86-84b8-4105a74a9f34";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/mnt/store" =
    { device = "/dev/disk/by-uuid/532605bb-8955-472c-8cb0-245448610829";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."cryptstor".device = "/dev/disk/by-uuid/e7c8ffc3-82cb-46e5-afd3-d72d28732a2e";

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
