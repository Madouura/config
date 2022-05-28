let
  asusctl_pr_tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/589b192a76c9854e19850d746d074bb5ad605f38.tar.gz";
in {
  imports = [
    "${asusctl_pr_tar}/nixos/modules/services/misc/asusctl.nix"
    "${asusctl_pr_tar}/nixos/modules/services/misc/supergfxctl.nix"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      asusctl = prev.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/asusctl/default.nix" { };
      supergfxctl = prev.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/supergfxctl/default.nix" { };
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
