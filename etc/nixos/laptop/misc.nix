{ pkgs, ... }:

{
  security.pam.services."mado".fprintAuth = true;

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaPersistenced = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
#      sync.enable = true;
      offload.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:7:0:0";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>eDP-1</connector>
                <vendor>CMN</vendor>
                <product>0x152a</product>
                <serial>0x00000000</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>165.00254821777344</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    ''}"
  ];
}
