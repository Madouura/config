let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [ <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix> ];
  disabledModules = [ "virtualisation/libvirtd.nix" ];
}
