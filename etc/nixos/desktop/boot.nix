{
  boot = {
    kernelModules = [ "nct6775" "jc42" ];
    extraModprobeConfig = "options kvmfr static_size_mb=64";

    initrd = {
      availableKernelModules = [ "vfio-pci" ];

      preDeviceCommands = ''
        DEVS="0000:10:00.0 0000:10:00.1 0000:12:00.3"

        for DEV in $DEVS; do
          echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done

        modprobe -i vfio-pci
      '';
    };
  };
}
