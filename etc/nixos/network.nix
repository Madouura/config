{
  networking = {
    hostName = "ura";
    networkmanager.enable = true;
    wireguard.enable = true;
    firewall.checkReversePath = "loose";
  };
}
