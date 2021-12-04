{
  fileSystems."/mnt/store".options = [ "compress=zstd" "noatime" ];

  boot = {
    kernelParams = [ "iommu=pt" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    kernelModules = [ "nct6775" "jc42" ];

    initrd = {
      availableKernelModules = [ "vfio-pci" ];
      luks.devices."cryptwrot".device = "/dev/disk/by-uuid/7d93a38e-8320-452a-9868-64f6bfdf0b2d";

      preDeviceCommands = ''
        DEVS="0000:10:00.0 0000:10:00.1"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';
    };
  };
}
