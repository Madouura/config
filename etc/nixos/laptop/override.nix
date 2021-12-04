{
  imports = [
    <nixos-unstable/nixos/modules/hardware/video/nvidia.nix>
    ../services/tetrd.nix
  ];

  disabledModules = [ "hardware/video/nvidia.nix" ];
}
