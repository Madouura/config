{
  fileSystems."/mnt/stor".options = [ "compress=zstd" "noatime" ];

  boot = {
    kernelModules = [ "nct6775" "jc42" ];

    initrd = {
      availableKernelModules = [ "vfio-pci" ];
      luks.devices."cryptroot1".device = "/dev/disk/by-uuid/1c0fe352-b515-4610-90ff-9832c233710e";

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
