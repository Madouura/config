{
  boot = {
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

    initrd = {
      availableKernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      luks.devices."cryptroot1".device = "/dev/disk/by-uuid/c529c431-097a-45f5-9753-5f2245245367";
    };
  };
}
