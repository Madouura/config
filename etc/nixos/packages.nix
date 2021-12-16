{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Utilities
    lm_sensors
    htop
    nload

    ( # Manually link virtiofsd
      pkgs.stdenv.mkDerivation {
        name = "virtiofsd-link";

        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pkgs.qemu}/libexec/virtiofsd $out/bin/
        '';
      }
    )
  ];
}
