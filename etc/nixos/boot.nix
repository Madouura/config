{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    kernelParams = [ "iommu=pt" ];
    kernelModules = [ "binder_linux" ];
    extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    initrd.availableKernelModules = [ "amdgpu" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };

  fileSystems = {
    "/".options = [ "discard" "noatime" "commit=60" "barrier=0" ];
    "/boot".options = [ "discard" ];
  };
}
