{ pkgs, ... }:

let
  bcachefs_tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/ae8c5d35b5ee56ebe883a4cc6fe696e90126bf03.tar.gz";
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
      linuxPackages_testing_bcachefs = (import "${bcachefs_tar}" { config.allowUnfree = true; }).linuxPackages_testing_bcachefs;
      bcachefs-tools = pkgs.callPackage "${bcachefs_tar}/pkgs/tools/filesystems/bcachefs-tools/default.nix" { };
    })

    (final: prev: {
      asusctl = pkgs.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/asusctl/default.nix" { };
      supergfxctl = pkgs.callPackage "${asusctl_pr_tar}/pkgs/tools/misc/supergfxctl/default.nix" { };
    })

    (final: prev: {
      tetrd = pkgs.callPackage "${tetrd_tar}/pkgs/applications/networking/tetrd/default.nix" { };
    })
  ];
}
