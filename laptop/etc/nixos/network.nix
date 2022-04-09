{
  networking = {
    hostName = "tsuki";
    networkmanager.enable = true;
    wireguard.enable = true;
    firewall.checkReversePath = "loose";
  };
}
