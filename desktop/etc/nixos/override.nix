{ pkgs, ... }:

let
  baseConfig = { allowUnfree = true; };
#  unstable = import <nixos-unstable> { config = baseConfig; };
  nixpkgs-local = import <nixpkgs-local> { config = baseConfig; };
in {
  # Until next NixOS version release
#  imports = [ <nixos-unstable/nixos/modules/hardware/xone.nix> ];

  nixpkgs.config.packageOverrides = pkgs: {
    bcachefs-tools = nixpkgs-local.bcachefs-tools;
    linux_testing_bcachefs = nixpkgs-local.linux_testing_bcachefs;
    linuxPackages_testing_bcachefs = nixpkgs-local.linuxPackages_testing_bcachefs;
#    xone = unstable.xone;
#    xow_dongle-firmware = unstable.xow_dongle-firmware;
  };
}
