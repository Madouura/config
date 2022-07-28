{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Utilities
    lm_sensors
    htop
    nload
    ebtables
    dnsmasq
    pciutils
    usbutils
    gptfdisk
    minicom
    picocom
#    gamescope
    chrome-gnome-shell
    virtmanager
    virtiofsd
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnome.gnome-settings-daemon
  ];
}
