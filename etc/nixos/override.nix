let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [
    <nixos-unstable/nixos/modules/hardware/corectrl.nix>
    <nixos-unstable/nixos/modules/services/hardware/joycond.nix>
    <nixos-unstable/nixos/modules/services/networking/mullvad-vpn.nix>
  ];

  disabledModules = [
    "hardware/corectrl.nix"
    "services/hardware/joycond.nix"
    "services/networking/mullvad-vpn.nix"
  ];
}
