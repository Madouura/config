let
  unstable = import <nixos-unstable> { };
in {
  # Until #153095 merge
  imports = [ ./stage-1.nix ];
  disabledModules = [ "system/boot/stage-1.nix" ];

  # Until next NixOS version change
  nixpkgs.config.packageOverrides = pkgs: {
    looking-glass-client = unstable.looking-glass-client;
  };
}
