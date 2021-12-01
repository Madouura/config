let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [
    <nixos-unstable/nixos/modules/hardware/corectrl.nix>
    <nixos-unstable/nixos/modules/virtualisation/waydroid.nix>
    <nixos-unstable/nixos/modules/services/hardware/joycond.nix>
    <nixos-unstable/nixos/modules/services/networking/mullvad-vpn.nix>
  ];

  disabledModules = [
    "hardware/corectrl.nix"
    "virtualisation/waydroid.nix"
    "services/hardware/joycond.nix"
    "services/networking/mullvad-vpn.nix"
  ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      joycond = unstable.joycond;
      corectrl = unstable.corectrl;
      steam = unstable.steam;
      mullvad-vpn = unstable.mullvad-vpn;
      waydroid = unstable.waydroid;
    };
  };
}
