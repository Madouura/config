{
  boot = {
    extraModprobeConfig = "options kvmfr static_size_mb=32";

    initrd = {
      availableKernelModules = [ "vfio-pci" ];
      luks.devices."cryptwrot".device = "/dev/disk/by-uuid/7128b6e5-af2b-41d8-893a-3252af7a98ec";

      preDeviceCommands = ''
        DEVS="0000:01:00.0 0000:01:00.1"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';
    };
  };

  fileSystems = {
    "/mnt/stor".options = [ "discard" "noatime" "commit=60" "barrier=0" ];
  };
}
