{ pkgs, ... }:

let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [ <nixos-unstable/nixos/modules/hardware/xone.nix> ];
  disabledModules = [ "hardware/xone.nix" ];

  nixpkgs.config.packageOverrides = pkgs: {
    bcachefs-tools = unstable.bcachefs-tools;
    linux_testing_bcachefs = unstable.linux_testing_bcachefs;
    linuxPackages_testing_bcachefs = unstable.linuxPackages_testing_bcachefs;
    xone = unstable.xone;
    xow_dongle-firmware = unstable.xow_dongle-firmware;
  };
}
