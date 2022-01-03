let
  unstable = import <nixos-unstable-small> { };
in {
  # Until #153095 merge
  imports = [ ./misc/stage-1.nix ];
  disabledModules = [ "system/boot/stage-1.nix" ];

  # Until next NixOS version change
  nixpkgs.config.packageOverrides = pkgs: {
    looking-glass-client = unstable.looking-glass-client;
  };
}
