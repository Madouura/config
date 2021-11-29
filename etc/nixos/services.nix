{
  services = {
    timesyncd.enable = true;
    cron.enable = true;
    printing.enable = true;
    mullvad-vpn.enable = true;
    joycond.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      media-session.config.bluez-monitor.rules = [
        {
          # Matches all cards
          matches = [ { "device.name" = "~bluez_card.*"; } ];

          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
              # SBC-XQ is not expected to work on all headset + adapter combinations.
              "bluez5.sbc-xq-support" = true;
            };
          };
        }

        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];

          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };

    # Ports: 9050, 9063, 8118
    tor = {
      enable = true;
      client.enable = true;
      torsocks.enable = true;
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      videoDrivers = [ "amdgpu" ];
    };

    gnome = {
      chrome-gnome-shell.enable = true;
      gnome-keyring.enable = true;
    };
  };
}
