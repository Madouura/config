let
  unstable = import <nixos-unstable-small> { };
in {
  # Until next NixOS version change
  nixpkgs.config.packageOverrides = pkgs: {
    looking-glass-client = unstable.looking-glass-client;
    qemu = unstable.qemu;
  };
}