{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Utilities
    lm_sensors
    htop
    nload
    pciutils
    usbutils
    gptfdisk
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
  ];
}