# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/cryptroot0";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."cryptroot0".device = "/dev/disk/by-uuid/cd56be7b-d4ec-4d51-8dcd-e7cf1f915136";

  fileSystems."/var/log" =
    { device = "/dev/mapper/cryptroot0";
      fsType = "btrfs";
      options = [ "subvol=@var_log" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/mapper/cryptroot0";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/cryptroot0";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F0AC-C5F8";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
