{ pkgs, ... }:

{
  boot = {
    kernelParams = [ "iommu=pt" "video=efifb:off" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "nct6775" "jc42" ];
    supportedFilesystems = [ "btrfs" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    initrd = {
      availableKernelModules = [ "amdgpu" "vfio-pci" ];
      supportedFilesystems = [ "btrfs" ];

      luks.devices = {
        "cryptroot0".allowDiscards = true;

        "cryptroot1" = {
          allowDiscards = true;
          device = "/dev/disk/by-uuid/87cdb6ee-79c7-48c7-aefd-a0f44acadb2c";
        };
      };

      preDeviceCommands = ''
        DEVS="0000:10:00.0 0000:10:00.1 0000:12:00.3"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';

#      postDeviceCommands = pkgs.lib.mkBefore ''
#        btrfs device scan
#        mkdir -p /mnt
#        mount -o subvol=/ /dev/mapper/cryptroot0 /mnt
#        btrfs subvolume list -o /mnt/root |
#        cut -f9 -d' ' |

#        while read subvolume; do
#          echo "Deleting /$subvolume subvolume..."
#          btrfs subvolume delete "/mnt/$subvolume"
#        done &&

#        echo "Deleting /root subvolume..." &&
#        btrfs subvolume delete /mnt/root
#        echo "Restoring blank /root subvolume..."
#        btrfs subvolume snapshot /mnt/root-blank /mnt/root
#        umount /mnt
#      '';
    };

#    postBootCommands = ''
#      ln -sf /persist/root/.nix-channels /root/.nix-channels
#    '';
  };

  fileSystems = {
    "/boot".label = "boot";
    "/nix".options = [ "compress=zstd" "discard" "noatime" ];
    "/persist".options = [ "compress=zstd" "discard" "noatime" ];
    "/home".options = [ "compress=zstd" "discard" "noatime" ];

    "/" = {
      label = "root";
      options = [ "compress=zstd" "discard" "noatime" ];
    };

    "/var/log" = {
      options = [ "compress=zstd" "discard" "noatime" ];
      neededForBoot = true;
    };

    "/mnt/store" = {
      label = "stor";
      options = [ "compress=zstd" "noatime" ];
    };
  };
}
