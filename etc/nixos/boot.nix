let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  boot = {
    kernelPackages = unstable.linuxPackages_xanmod;
    kernelModules = [ "binder_linux" ];
    kernelParams = [ "iommu=pt" ];
    kernel.sysctl = { "kernel.sysrq" = 1; };
    supportedFilesystems = [ "btrfs" ];
    extraModprobeConfig = "options kvm_amd nested=1";

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    initrd = {
      availableKernelModules = [ "amdgpu" ];
      supportedFilesystems = [ "btrfs" ];
    };
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "autodefrag" "discard=async" "noatime" ];
    "/home".options = [ "compress=zstd" "autodefrag" "discard=async" "noatime" ];
    "/.snapshots".options = [ "compress=zstd" "autodefrag" "discard=async" "noatime" ];
    "/var/log".options = [ "compress=zstd" "autodefrag" "discard=async" "noatime" ];
  };
}
