let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  # Until next NixOS version change
  imports = [ <nixos-unstable/nixos/modules/services/networking/tetrd.nix> ];
  disabledModules = [ "services/networking/tetrd.nix" ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      looking-glass-client = unstable.looking-glass-client;
      qemu = unstable.qemu;
      tetrd = unstable.tetrd;
    };
  };
}
