{ config, ... }:

{
  boot = {
    kernelParams = [ "iommu=pt" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    kernelModules = [ "binder_linux" "kvmfr" ];
    extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];
    initrd.availableKernelModules = [ "amdgpu" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };
}
