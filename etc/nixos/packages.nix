let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  environment.systemPackages = with unstable; [
    # Utilities
    lm_sensors
    htop
    nload
    corectrl
  ];
}
