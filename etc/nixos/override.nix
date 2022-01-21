let
  unstable = import <nixos-unstable> { };
in {
  # Until next NixOS version change
  imports = [ <nixos-unstable/nixos/modules/system/boot/stage-1.nix> ];
  disabledModules = [ "system/boot/stage-1.nix" ];

  nixpkgs.config.packageOverrides = pkgs: {
    looking-glass-client = unstable.looking-glass-client;
    qemu = unstable.qemu;
    wine-staging = unstable.wine-staging;
  };
}
