let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  boot = {
    kernelPackages = unstable.linuxPackages_xanmod;
    supportedFilesystems = [ "btrfs" ];
    initrd.supportedFilesystems = [ "btrfs" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "discard" "noatime" ];
    "/home".options = [ "compress=zstd" "discard" "noatime" ];
    "/.snapshots".options = [ "compress=zstd" "discard" "noatime" ];
    "/var/log".options = [ "compress=zstd" "discard" "noatime" ];
  };
}
