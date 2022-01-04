{
  services = {
    hardware.xow.enable = true;

    pipewire = {
      config = {
        pipewire = {
          "context.properties" = {
            "default.clock.rate" = 192000;
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
}
