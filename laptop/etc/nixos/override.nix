{ pkgs, ... }:

let
  baseConfig = { allowUnfree = true; };
  nixpkgs-local = import <nixpkgs-local> { config = baseConfig; };
in {
  nixpkgs.config.packageOverrides = pkgs: {
    bcachefs-tools = nixpkgs-local.bcachefs-tools;
    linux_testing_bcachefs = nixpkgs-local.linux_testing_bcachefs;
    linuxPackages_testing_bcachefs = nixpkgs-local.linuxPackages_testing_bcachefs;
  };
}
