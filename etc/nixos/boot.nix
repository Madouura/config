{ config, ... }:

{
  boot = {
    kernelParams = [ "iommu=pt" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    kernelModules = [ "binder_linux" "kvmfr" ];
    extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];
    supportedFilesystems = [ "bcachefs" ];

    initrd = {
      availableKernelModules = [ "amdgpu" ];
      supportedFilesystems = [ "bcachefs" ];
    };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };
}
