let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [
    <nixos-unstable/nixos/modules/hardware/corectrl.nix>
    <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix>
    <nixos-unstable/nixos/modules/virtualisation/waydroid.nix>
    <nixos-unstable/nixos/modules/services/hardware/joycond.nix>
    <nixos-unstable/nixos/modules/services/networking/mullvad-vpn.nix>
    <nixos-unstable/nixos/modules/services/desktops/pipewire/pipewire.nix>
    <nixos-unstable/nixos/modules/services/desktops/pipewire/pipewire-media-session.nix>
  ];

  disabledModules = [
    "hardware/corectrl.nix"
    "virtualisation/libvirtd.nix"
    "virtualisation/waydroid.nix"
    "services/hardware/joycond.nix"
    "services/networking/mullvad-vpn.nix"
    "services/desktops/pipewire/pipewire.nix"
    "services/desktops/pipewire/pipewire-media-session.nix"
  ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      corectrl = unstable.corectrl;
      waydroid = unstable.waydroid;
      joycond = unstable.joycond;
      mullvad-vpn = unstable.mullvad-vpn;
      steam = unstable.steam;
    };
  };
}
