{ pkgs, ... }:

{
  services = {
    tetrd.enable = true;

    pipewire = {
      config.pipewire = {
        "context.properties" = {
          "link.max-buffers" = 16;
          "log.level" = 2;
          "default.clock.rate" = 44100;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 512;
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
      };

      config.pipewire-pulse = {
        "context.properties" = { "log.level" = 2; };

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
          { name = "libpipewire-module-client-node"; }
          { name = "libpipewire-module-adapter"; }
          { name = "libpipewire-module-metadata"; }

          {
            name = "libpipewire-module-protocol-pulse";

            args = {
              "pulse.min.req" = "256/44100";
              "pulse.default.req" = "256/44100";
              "pulse.max.req" = "256/44100";
              "pulse.min.quantum" = "256/44100";
              "pulse.max.quantum" = "256/44100";
              "server.address" = [ "unix:native" ];
            };
          }
        ];

        "stream.properties" = {
          "node.latency" = "256/44100";
          "resample.quality" = 1;
        };
      };

      media-session.config.alsa-monitor = {
        rules = [
          {
            matches = [ { "node.name" = "alsa_output.*"; } ];

            actions = {
              update-props = {
                "audio.format" = "S16LE";
                "audio.rate" = 44100;
                "api.alsa.period-size" = 256;
              };
            };
          }
        ];
      };
    };

    xserver = {
      displayManager.gdm.nvidiaWayland = true;
      videoDrivers = [ "nvidia" ];

      deviceSection = ''
        Option "TearFree" "true"
        Option "VariableRefresh" "true"
      '';
    };

    fprintd = {
      enable = true;

      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };
}
