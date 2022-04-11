{ pkgs, ... }:

let
  bcachefs_tar = fetchTarball "https://github.com/Madouura/nixpkgs/archive/833899a6d9366174a127d8428f658aa90081a6a7.tar.gz";
in {
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linuxPackages_testing_bcachefs;
      bcachefs-tools = pkgs.callPackage "${bcachefs_tar}/pkgs/tools/filesystems/bcachefs-tools/default.nix" { };
    })
  ];
}
