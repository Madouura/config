{
  networking = {
    hostName = "ura";
    networkmanager.enable = true;
    wireguard.enable = true;
    firewall.checkReversePath = "loose";

    interfaces = {
      enp5s0.useDHCP = true;
      enp6s0.useDHCP = true;
      wlp7s0.useDHCP = true;
    };
  };
}
