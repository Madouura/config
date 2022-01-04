{ pkgs, ... }:

let
  monitors = pkgs.writeText "gdm-monitors.xml" ''
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
  '';

  win11Vars = pkgs.writeText "win11-vm-vars.conf" ''
    ALLOWED_CPUS=0-3
    TOTAL_CPUS=0-15
    ON_GOVERNOR=performance
    OFF_GOVERNOR=ondemand
  '';
in {
  security.pam.services."mado".fprintAuth = true;

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitors}"
    "L+ /var/lib/libvirt/hooks/vars.conf - - - - ${win11Vars}"
  ];
}
