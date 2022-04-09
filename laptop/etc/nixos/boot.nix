{
  boot = {
    kernel.sysctl = { "kernel.sysrq" = 1; };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    initrd = {
      availableKernelModules = [ "amdgpu" ];
      luks.devices.cryptswap.device = "/dev/disk/by-uuid/3b9dc6ca-0142-4872-9acd-dc908c3b06ba";
    };
  };
}
