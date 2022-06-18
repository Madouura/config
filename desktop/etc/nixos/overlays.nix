# let
#  bcachefs_tar = fetchTarball "https://github.com/Madouura/nixpkgs/archive/ee111fc78b1b003fc98a0155dd1e3f36dab2e091.tar.gz";
#  nur_tar = fetchTarball "https://github.com/nix-community/nur-combined/archive/master.tar.gz";
# in {
{
  nixpkgs.overlays = [
#    (final: prev: {
#      linux_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linux_testing_bcachefs;
#      linuxPackages_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linuxPackages_testing_bcachefs;
#      bcachefs-tools = (import "${bcachefs_tar}" { config.allowUnfree = true; }).bcachefs-tools;
#    })

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
