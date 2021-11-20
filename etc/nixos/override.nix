let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  imports = [
    <nixos-unstable/nixos/modules/virtualisation/libvirtd.nix>
    <nixos-unstable/nixos/modules/services/hardware/joycond.nix>
  ];

  disabledModules = [
    "virtualisation/libvirtd.nix"
    "services/hardware/joycond.nix"
  ];

  nixpkgs.config = baseConfig // {
    packageOverrides = pkgs: {
      linuxPackages_latest = unstable.linuxPackages_latest;
      libvirt = unstable.libvirt;
      qemu = unstable.qemu;
      OVMFFull = unstable.OVMFFull;
      joycond = unstable.joycond;
      steam = unstable.steam;
    };
  };
}
