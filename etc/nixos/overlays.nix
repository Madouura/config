let
  unstable = (import <nixos-unstable> { });
in {
  imports = [
    <nixos-unstable/nixos/modules/virtualisation/waydroid.nix>
    <nixos-unstable/nixos/modules/services/networking/monero.nix>
  ];

  disabledModules = [
    "virtualisation/waydroid.nix"
    "services/networking/monero.nix"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      linuxKernel = unstable.linuxKernel;
      linuxPackages_zen = unstable.linuxPackages_zen;
      virtiofsd = unstable.virtiofsd;
      waydroid = unstable.waydroid;
      rpcs3 = unstable.rpcs3;
      gamescope = unstable.gamescope;
      p2pool = unstable.p2pool;
      xmrig = unstable.xmrig;
      monero-cli = unstable.monero-cli;
      monero-gui = unstable.monero-gui;
      ledger-live-desktop = unstable.ledger-live-desktop;
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
