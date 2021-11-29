let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  boot = {
    kernelPackages = unstable.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    initrd = {
      supportedFilesystems = [ "btrfs" ];
      availableKernelModules = [ "amdgpu" ];
    };
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "discard" "noatime" ];
    "/home".options = [ "compress=zstd" "discard" "noatime" ];
    "/.snapshots".options = [ "compress=zstd" "discard" "noatime" ];
    "/var/log".options = [ "compress=zstd" "discard" "noatime" ];
  };
}
