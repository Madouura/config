{
  networking = {
    hostName = "ura";
    useDHCP = false;

    interfaces = {
      enp5s0.useDHCP = true;
      enp6s0.useDHCP = true;
      wlp7s0.useDHCP = true;
    };
  };
}
