# let
#  nur_tar = fetchTarball "https://github.com/nix-community/nur-combined/archive/master.tar.gz";
# in {
{
  nixpkgs.overlays = [
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
