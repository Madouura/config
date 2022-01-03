let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable-small> { config = baseConfig; };
in {
  # Until next NixOS version change
  imports = [ <nixos-unstable-small/nixos/modules/services/networking/tetrd.nix> ];
  disabledModules = [ "services/networking/tetrd.nix" ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      tetrd = unstable.tetrd;
    };
  };
}
