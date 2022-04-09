{
  boot = {
    kernelModules = [ "nct6775" "jc42" ];
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
      luks.devices.cryptswap.device = "/dev/disk/by-uuid/a5a8d93f-e4a8-4b37-a5a4-88ea43f8d25d";
    };
  };
}
