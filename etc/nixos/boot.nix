{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "iommu=pt" ];
    kernelModules = [ "nct6775" "jc42" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    resumeDevice = "/dev/disk/by-uuid/a8e45243-e6ae-47a3-b3a8-965c2eb0ed98";

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    initrd = {
      availableKernelModules = [ "amdgpu" "vfio-pci" ];
      luks.devices."cryptswap".device = "/dev/disk/by-uuid/1acd8b73-20f1-4697-915a-b931e5b0b0a1";

      preDeviceCommands = ''
        DEVS="0000:10:00.0 0000:10:00.1"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';
    };
  };

  fileSystems = {
    "/".options = [ "discard" ];
    "/boot".options = [ "discard" ];
    "/mnt/cach".options = [ "discard" ];

    "/home/mado/.virtiofs/Music" = {
      device = "/mnt/stor/home/mado/Music";
      fsType = "none";
      options = [ "ro" "bind" ];
    };

    "/home/mado/.virtiofs/Games/Hentai" = {
      device = "/mnt/stor/home/mado/Games/Hentai";
      fsType = "none";
      options = [ "rw" "bind" ];
    };

    "/home/mado/.virtiofs/Games/SteamLibrary" = {
      device = "/mnt/cach/home/mado/Games/SteamLibrary";
      fsType = "none";
      options = [ "rw" "bind" ];
    };
  };
}
