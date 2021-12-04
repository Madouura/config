let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  boot = {
    kernelPackages = unstable.linuxPackages_xanmod;
    kernelModules = [ "amdgpu" "binder_linux" ];
    supportedFilesystems = [ "btrfs" ];

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
    "/".options = [ "compress=zstd" "discard" "noatime" ];
    "/home".options = [ "compress=zstd" "discard" "noatime" ];
    "/.snapshots".options = [ "compress=zstd" "discard" "noatime" ];
    "/var/log".options = [ "compress=zstd" "discard" "noatime" ];
  };
}
