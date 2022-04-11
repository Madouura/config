{ pkgs, ... }:

let
  bcachefs_tar = fetchTarball "https://github.com/Madouura/nixpkgs/archive/9481a9c4ecf750c678f205713794be66ad2ad95b.tar.gz";
in {
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linuxPackages_testing_bcachefs;
      bcachefs-tools = pkgs.callPackage "${bcachefs_tar}/pkgs/tools/filesystems/bcachefs-tools/default.nix" { };
    })
  ];
}
