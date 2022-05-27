{ pkgs, ... }:

{
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  time.timeZone = "America/Chicago";
  security.rtkit.enable = true;
  virtualisation.waydroid.enable = true;
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - /etc/nixos/resources/monitors.xml"
    "L+ /var/lib/AccountsService/users/mado - - - - /etc/nixos/resources/gdm"
    "L+ /var/lib/AccountsService/icons/mado - - - - /etc/nixos/resources/avatar.png"
  ];

  environment = {
    variables = {
      EDITOR = "nano";
      VISUAL = "nano";
    };

    etc = {
#      "wireplumber/alsa.lua.d/51-alsa-monitor.lua".text = ''
#        alsa_monitor.properties = {
#          ["audio.format"] = "S24LE";
#          ["audio.rate"] = 192000;
#          ["api.alsa.period-size"] = 256;
#        };
#      '';

      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
			    ["bluez5.enable-msbc"] = true,
			    ["bluez5.enable-hw-volume"] = true,
			    ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        };
      '';
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    xone.enable = true;
    opengl.driSupport32Bit = true;
  };
}
