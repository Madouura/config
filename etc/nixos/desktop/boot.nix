{
  boot = {
    kernelModules = [ "nct6775" "jc42" ];

    initrd = {
      availableKernelModules = [ "vfio-pci" ];
      luks.devices."cryptwrot".device = "/dev/disk/by-uuid/1b847317-5ac5-4cf0-982d-88177c18b532";

      preDeviceCommands = ''
        DEVS="0000:10:00.0 0000:10:00.1 0000:12:00.3"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';
    };
  };

  fileSystems = {
    "/mnt/cach".options = [ "discard" "noatime" "commit=60" "barrier=0" ];
    "/mnt/stor".options = [ "noatime" "commit=60" "barrier=0" ];
  };
}
