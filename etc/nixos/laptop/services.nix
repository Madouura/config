{ pkgs, ... }:

{
  services = {
    asusctl.enable = true;
    tetrd.enable = true;

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

#    xserver = {
#      displayManager.gdm.nvidiaWayland = true;
#      videoDrivers = [ "nvidia" ];
#    };

    fprintd = {
      enable = true;

      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };

  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}
      GUEST_NAME="$1"
      OPERATION="$2"

      if [ "$GUEST_NAME" == "win11" ]; then
        if [ "$OPERATION" == "prepare" ]; then
          sync
          echo 3 > /proc/sys/vm/drop_caches
          sync
          echo 1 > /proc/sys/vm/compact_memory
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-3
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-3
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-3
        fi

        if [ "$OPERATION" == "release" ]; then
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
        fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';
}
