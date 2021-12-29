let
  small = import <nixos-small> { };
in {
  # Until nixos-21.11 channel updates
  nixpkgs.config = {
    packageOverrides = pkgs: {
      ares = small.ares;
      bcachefs-tools = small.bcachefs-tools;
      linux_testing_bcachefs = small.linux_testing_bcachefs;
      linuxPackages_testing_bcachefs = small.linuxPackages_testing_bcachefs;
    };
  };
}
