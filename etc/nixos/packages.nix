{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Utilities
    lm_sensors
    htop
    nload
    ebtables
    dnsmasq
  ];
}
