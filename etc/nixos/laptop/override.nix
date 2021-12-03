let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [
    <nixos-unstable/nixos/modules/hardware/video/nvidia.nix>
    ../services/tetrd.nix
  ];

  disabledModules = [ "hardware/video/nvidia.nix" ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      steam.run = unstable.steam.run;
    };
  };
}
