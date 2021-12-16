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
    { device = "/dev/disk/by-uuid/29566277-c617-4289-9e84-f9126bc38228";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/365bc972-b489-4dad-b3ce-fb2942a7c991";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C7E2-5906";
      fsType = "vfat";
    };

  fileSystems."/mnt/stor" =
    { device = "/dev/disk/by-uuid/6cd95da2-50fb-41b0-b400-4740186ab9f3";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptstor".device = "/dev/disk/by-uuid/0dd67068-99cc-4db6-91c2-78e3960df860";

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
