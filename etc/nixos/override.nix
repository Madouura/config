let
  unstable = import <nixos-unstable> { };
in {
  imports = [ ./services/waydroid.nix ];
  disabledModules = [ "virtualisation/waydroid.nix" ];

  # Until 1.1.14 in release-21.11
  nixpkgs.config = {
    packageOverrides = pkgs: {
      libgbinder = unstable.libgbinder;
    };
  };
}
