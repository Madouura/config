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
    gamescope
    chrome-gnome-shell
    virtmanager
    virtiofsd
    liquidctl
    openrgb
    conda
    git-lfs
    pcsx2
    rpcs3
    monero-gui
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnome.gnome-settings-daemon
  ];
}
