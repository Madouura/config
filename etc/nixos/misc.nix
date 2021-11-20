{ pkgs, ... }:

{
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];

  security = {
    sudo.extraConfig = "Defaults lecture = never";
    rtkit.enable = true;

    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.corectrl.helper.init" || action.id == "org.corectrl.helperkiller.init") &&
             subject.local == true &&
             subject.active == true &&
             subject.isInGroup("corectrl")) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  systemd.tmpfiles.rules = [
#    "L /var/lib/libvirt/images/win11.img - - - - /persist/var/lib/libvirt/images/win11.img"
#    "L /var/lib/libvirt/qemu/nvram/win11_VARS.fd - - - - /persist/var/lib/libvirt/qemu/nvram/win11_VARS.fd"
#    "L /var/lib/libvirt/qemu/win11.xml - - - - /persist/var/lib/libvirt/qemu/win11.xml"
#    "C /var/lib/AccountsService/icons/mado - - - - /persist/var/lib/AccountsService/icons/mado"

    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>720</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
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

  environment = {
#    etc = {
#      nixos.source = "/persist/etc/nixos";
#      NIXOS.source = "/persist/etc/NIXOS";
#      machine-id.source = "/persist/etc/machine-id";
#      adjtime.source = "/persist/etc/adjtime";
#      group.source = "/persist/etc/group";
#      passwd.source = "/persist/etc/passwd";
#      shadow.source = "/persist/etc/shadow";
#      "NetworkManager/system-connections".source = "/persist/etc/NetworkManager/system-connections";
#      "mullvad-vpn".source = "/persist/etc/mullvad-vpn";
#    };

    variables = {
      EDITOR = "nano";
      VISUAL = "nano";
    };
  };

  hardware = {
    xpadneo.enable = true;
    cpu.amd.updateMicrocode = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = false;
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";

    qemu = {
      swtpm.enable = true;
      ovmf.package = pkgs.OVMFFull;
    };
  };
}
