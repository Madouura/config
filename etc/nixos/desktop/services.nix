let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  services = {
    udev.packages = [ unstable.dolphinEmuMaster ];

    pipewire = {
      config.pipewire = {
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
              "pulse.min.req" = "256/192000";
              "pulse.default.req" = "256/192000";
              "pulse.max.req" = "256/192000";
              "pulse.min.quantum" = "256/192000";
              "pulse.max.quantum" = "256/192000";
              "server.address" = [ "unix:native" ];
            };
          }
        ];

        "stream.properties" = {
          "node.latency" = "256/192000";
          "resample.quality" = 1;
        };
      };

      media-session.config.alsa-monitor = {
        rules = [
          {
            matches = [ { "node.name" = "alsa_output.*"; } ];

            actions = {
              update-props = {
                "audio.format" = "S24LE";
                "audio.rate" = 192000;
                "api.alsa.period-size" = 256;
              };
            };
          }
        ];
      };

      xserver = {
        videoDrivers = [ "amdgpu" ];

        deviceSection = ''
          Option "TearFree" "true"
          Option "VariableRefresh" "true"
        '';
      };
    };
  };

  systemd.services.prepare-ivshmem = {
    enable = true;
    description = "Prepare IVSHMEM";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "mado";
      Group = "qemu-libvirtd";
      ExecStart = "${unstable.coreutils}/bin/dd bs=1M count=16 if=/dev/zero of=/dev/shm/scream-ivshmem";
    };
  };
}
