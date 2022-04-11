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
      luks.devices.cryptswap.device = "/dev/disk/by-uuid/85815e8c-97fc-4c28-ad45-5441fa54d235";
    };
  };
}
