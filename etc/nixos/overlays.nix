let
#  nur_tar = fetchTarball "https://github.com/nix-community/nur-combined/archive/master.tar.gz";
  vfsd_tar = fetchTarball "https://github.com/astro/nixpkgs/archive/082dd22447728db8acf13a5a013a6bff2a89f1dd.tar.gz";
in {
  nixpkgs.overlays = [
    (final: prev: {
#      virtiofsd = (import <nixos-unstable> { }).virtiofsd;
      virtiofsd = (import "${vfsd_tar}" { }).virtiofsd;
    })

#    (final: prev: {
#      gamescope = (import "${nur_tar}" { pkgs = prev; }).repos.dukzcry.gamescope;
#    })

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
