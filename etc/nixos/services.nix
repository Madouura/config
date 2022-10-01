{ pkgs, ... }:

{
  services = {
    timesyncd.enable = true;
    cron.enable = true;
    earlyoom.enable = true;
    printing.enable = true;
    mullvad-vpn.enable = true;
    joycond.enable = true;
    monero.enable = true;
    udev.packages = [ pkgs.dolphinEmuMaster ];

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
      digimend.enable = true;
      videoDrivers = [ "amdgpu" ];

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
            "default.clock.rate" = 192000;
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
                "pulse.min.req" = "256/192000";
                "pulse.default.req" = "256/192000";
                "pulse.max.req" = "256/192000";
                "pulse.min.quantum" = "256/192000";
                "pulse.max.quantum" = "256/192000";
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
            "node.latency" = "256/192000";
            "resample.quality" = 1;
          };
        };
      };
    };
  };
}
