let
  unstable = (import <nixos-unstable> { });
in {
  imports = [ <nixos-unstable/nixos/modules/virtualisation/waydroid.nix> ];
  disabledModules = [ "virtualisation/waydroid.nix" ];

  nixpkgs.overlays = [
    (final: prev: {
      linuxKernel = unstable.linuxKernel;
      linuxPackages_zen = unstable.linuxPackages_zen;
      virtiofsd = unstable.virtiofsd;
      waydroid = unstable.waydroid;
      rpcs3 = unstable.rpcs3;
      gamescope = unstable.gamescope;
    })

    (final: prev: {
      protonup = prev.protonup.overrideAttrs (old: {
        src = prev.python3Packages.fetchPypi {
          pname = "protonup-ng";
          version = "0.2.1";
          sha256 = "005ixhyg2369kcdwvcxwrhfdyh0q9s6p0pyvhqlhxyxphqv3saxg";
        };
      });
    })
  ];
}
