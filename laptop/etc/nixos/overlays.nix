{ pkgs, ... }:

let
  asusctl_pr_tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/a4a81b6f6c27e5a964faea25b7b5cbe611f98691.tar.gz";
  tetrd_tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/5721945070e61e6d92c8a2391624673deb733105.tar.gz";
in {
  imports = [
    "${asusctl_pr_tar}/nixos/modules/services/misc/asusctl.nix"
    "${asusctl_pr_tar}/nixos/modules/services/misc/supergfxctl.nix"
    "${tetrd_tar}/nixos/modules/services/networking/tetrd.nix"
  ];

  ## Remove later (asusctl)
  services.power-profiles-daemon.enable = true;

  systemd.services.power-profiles-daemon = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };
  ## Remove later (asusctl)

  nixpkgs.overlays = [
    (final: prev: {
      asusctl = pkgs.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/asusctl/default.nix" { };
      supergfxctl = pkgs.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/supergfxctl/default.nix" { };
    })

    (final: prev: {
      tetrd = pkgs.callPackage "${tetrd_tar}/pkgs/applications/networking/tetrd/default.nix" { };
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
