{
  networking = {
    hostName = "tsuki";
    networkmanager.enable = true;
    wireguard.enable = true;
    firewall.checkReversePath = "loose";

    interfaces = {
      enp3s0.useDHCP = true;
      tun0.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };
}
