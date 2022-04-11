{ pkgs, ... }:

let
  bcachefs_tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/ae8c5d35b5ee56ebe883a4cc6fe696e90126bf03.tar.gz";
in {
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linuxPackages_testing_bcachefs;
      bcachefs-tools = pkgs.callPackage "${bcachefs_tar}/pkgs/tools/filesystems/bcachefs-tools/default.nix" { };
    })
  ];
}
