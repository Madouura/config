{ pkgs, ... }:

let
  monitors = pkgs.writeText "gdm-monitors.xml" ''
    <monitors version="2">
      <configuration>
        <logicalmonitor>
          <x>2560</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>HDMI-1</connector>
              <vendor>GSM</vendor>
              <product>LG TV SSCR2</product>
              <serial>0x01010101</serial>
            </monitorspec>
            <mode>
              <width>3840</width>
              <height>2160</height>
              <rate>120</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>0</x>
          <y>384</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>DP-2</connector>
              <vendor>DEL</vendor>
              <product>DELL S3220DGF</product>
              <serial>308JM73</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>164.05610656738281</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';

  win11Vars = pkgs.writeText "win11-vm-vars.conf" ''
    ALLOWED_CPUS=0-7,16-23
    TOTAL_CPUS=0-31
    ON_GOVERNOR=performance
    OFF_GOVERNOR=ondemand
  '';
in {
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitors}"
    "L+ /var/lib/libvirt/hooks/vars.conf - - - - ${win11Vars}"
  ];
}
