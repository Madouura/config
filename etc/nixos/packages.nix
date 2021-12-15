let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  environment.systemPackages = with unstable; [
    # Utilities
    lm_sensors
    htop
    nload
    unrar
    unar

    (unstable.stdenv.mkDerivation {
      name = "virtiofsd-link";

      buildCommand = ''
        mkdir -p $out/bin
        ln -s ${unstable.qemu}/libexec/virtiofsd $out/bin/
      '';
    })
  ];
}
