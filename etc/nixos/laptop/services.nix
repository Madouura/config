{ pkgs, ... }:

{
  services = {
    tetrd.enable = true;
    asusctl.enable = true;

    supergfxctl = {
      gfx-mode = "Integrated";
      gfx-vfio-enable = true;
    };

    pipewire = {
      config = {
        pipewire = {
          "context.properties" = {
            "default.clock.rate" = 48000;
          };
        };

        pipewire-pulse = {
          "context.modules" = [
            {
              args = {
                "pulse.min.req" = "256/48000";
                "pulse.default.req" = "256/48000";
                "pulse.max.req" = "256/48000";
                "pulse.min.quantum" = "256/48000";
                "pulse.max.quantum" = "256/48000";
              };
            }
          ];

          "stream.properties" = {
            "node.latency" = "256/48000";
          };
        };
      };

      media-session.config.alsa-monitor = {
        rules = [
          {
            actions = {
              update-props = {
                "audio.format" = "S16LE";
                "audio.rate" = 48000;
              };
            };
          }
        ];
      };
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
