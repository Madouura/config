{ pkgs, ... }:

{
  services = {
    timesyncd.enable = true;
    cron.enable = true;
    earlyoom.enable = true;
    printing.enable = true;
    mullvad-vpn.enable = true;
    joycond.enable = true;
    tetrd.enable = true;
    asusctl.enable = true;
    udev.packages = [ pkgs.dolphinEmuMaster ];

    supergfxctl = {
      enable = true;
      gfx-mode = "Nvidia";
    };

    # Ports: 9050, 9063, 8118
    tor = {
      enable = true;
      client.enable = true;
      torsocks.enable = true;
    };

    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      digimend.enable = true;
      videoDrivers = [ "amdgpu" "nvidia" ];

      displayManager.gdm = {
        enable = true;
        nvidiaWayland = true;
        autoSuspend = false;
      };

      deviceSection = ''
        Option "TearFree"        "true"
        Option "VariableRefresh" "true"
      '';
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      config = {
        pipewire = {
          "context.properties" = {
            "link.max-buffers" = 16;
            "log.level" = 2;
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 1024;
            "core.daemon" = true;
            "core.name" = "pipewire-0";
          };

          "context.modules" = [
            {
              name = "libpipewire-module-rtkit";
              flags = [ "ifexists" "nofail" ];

              args = {
                "nice.level" = -15;
                "rt.prio" = 88;
                "rt.time.soft" = 200000;
                "rt.time.hard" = 200000;
              };
            }

            { name = "libpipewire-module-protocol-native"; }
            { name = "libpipewire-module-profiler"; }
            { name = "libpipewire-module-metadata"; }
            { name = "libpipewire-module-spa-device-factory"; }
            { name = "libpipewire-module-spa-node-factory"; }
            { name = "libpipewire-module-client-node"; }
            { name = "libpipewire-module-client-device"; }

            {
              name = "libpipewire-module-portal";
              flags = [ "ifexists" "nofail" ];
            }

            {
              name = "libpipewire-module-access";
              args = { };
            }

            { name = "libpipewire-module-adapter"; }
            { name = "libpipewire-module-link-factory"; }
            { name = "libpipewire-module-session-manager"; }
          ];

          "context.objects" = [
            {
              factory = "spa-node-factory";
              args = {
                "factory.name"     = "support.node.driver";
                "node.name"        = "Dummy-Driver";
                "priority.driver"  = 8000;
              };
            }
            {
              factory = "adapter";
              args = {
                "factory.name"     = "support.null-audio-sink";
                "node.name"        = "Microphone-Proxy";
                "node.description" = "Microphone";
                "media.class"      = "Audio/Source/Virtual";
                "audio.position"   = "MONO";
              };
            }
            {
              factory = "adapter";
              args = {
                "factory.name"     = "support.null-audio-sink";
                "node.name"        = "Main-Output-Proxy";
                "node.description" = "Main Output";
                "media.class"      = "Audio/Sink";
                "audio.position"   = "FL,FR";
              };
            }
          ];
        };

        pipewire-pulse = {
          "context.properties" = { "log.level" = 2; };

          "context.modules" = [
            {
              name = "libpipewire-module-rtkit";
              flags = [ "ifexists" "nofail" ];

              args = {
                "pulse.min.req" = "256/48000";
                "pulse.default.req" = "256/48000";
                "pulse.max.req" = "256/48000";
                "pulse.min.quantum" = "256/48000";
                "pulse.max.quantum" = "256/48000";
                "nice.level" = -15;
                "rt.prio" = 88;
                "rt.time.soft" = 200000;
                "rt.time.hard" = 200000;
              };
            }

            { name = "libpipewire-module-protocol-native"; }
            { name = "libpipewire-module-client-node"; }
            { name = "libpipewire-module-adapter"; }
            { name = "libpipewire-module-metadata"; }

          {
              name = "libpipewire-module-protocol-pulse";

              args = {
                "server.address" = [ "unix:native" ];
              };
            }
          ];

          "stream.properties" = {
            "node.latency" = "256/48000";
            "resample.quality" = 1;
          };
        };
      };

      media-session = {
        enable = true;

        config = {
          alsa-monitor = {
            rules = [
              {
                matches = [ { "node.name" = "alsa_output.*"; } ];

                actions = {
                  update-props = {
                    "audio.format" = "S16LE";
                    "audio.rate" = 48000;
                    "api.alsa.period-size" = 256;
                  };
                };
              }
            ];
          };

          bluez-monitor.rules = [
            {
              matches = [ { "device.name" = "~bluez_card.*"; } ];

              actions = {
                "update-props" = {
                  "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
                  "bluez5.msbc-support" = true;
                  "bluez5.sbc-xq-support" = true;
                };
              };
            }

            {
              matches = [
                { "node.name" = "~bluez_input.*"; }
                { "node.name" = "~bluez_output.*"; }
              ];

              actions = {
                "node.pause-on-idle" = false;
              };
            }
          ];
        };
      };
    };
  };

  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };

    services = {
      asusd = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
      };

      supergfxd = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
