{ pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>720</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-1</connector>
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
        </configuration>
      </monitors>
    ''}"
  ];
}
