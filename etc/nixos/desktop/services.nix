let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  services = {
    udev.packages = [ unstable.dolphinEmuMaster ];
    hardware.xow.enable = true;

    pipewire = {
      config = {
        pipewire = {
          "context.properties" = {
            "default.clock.rate" = 192000;
            "default.clock.max-quantum" = 1024;
          };
        };

        pipewire-pulse = {
          "context.modules" = [
            {
              args = {
                "pulse.min.req" = "256/192000";
                "pulse.default.req" = "256/192000";
                "pulse.max.req" = "256/192000";
                "pulse.min.quantum" = "256/192000";
                "pulse.max.quantum" = "256/192000";
              };
            }
          ];

          "stream.properties" = {
            "node.latency" = "256/192000";
          };
        };
      };

      media-session.config.alsa-monitor = {
        rules = [
          {
            actions = {
              update-props = {
                "audio.format" = "S24LE";
                "audio.rate" = 192000;
              };
            };
          }
        ];
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
