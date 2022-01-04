{ pkgs, ... }:

let
  libvirtdInit = pkgs.writeShellScript "libvirtd-init.sh" ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';

  qemuHook = pkgs.writeShellScript "qemu-hook.sh" ''
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"
    ALLOWED_CPUS=0-3
    TOTAL_CPUS=0-15
    ON_GOVERNOR=performance
    OFF_GOVERNOR=ondemand

    if [ "$GUEST_NAME" == "win11" ]; then
      if [ "$OPERATION" == "prepare" ] && [ "$SUB_OPERATION" == "begin" ]; then
        for governor in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo $ON_GOVERNOR > $governor;
        done

        systemctl set-property --runtime -- user.slice AllowedCPUs=$ALLOWED_CPUS
        systemctl set-property --runtime -- system.slice AllowedCPUs=$ALLOWED_CPUS
        systemctl set-property --runtime -- init.scope AllowedCPUs=$ALLOWED_CPUS

        sync
        echo 3 > /proc/sys/vm/drop_caches
        sync
        echo 1 > /proc/sys/vm/compact_memory
      fi

      if [ "$OPERATION" == "release" ] && [ "$SUB_OPERATION" == "end" ]; then
        systemctl set-property --runtime -- user.slice AllowedCPUs=$TOTAL_CPUS
        systemctl set-property --runtime -- system.slice AllowedCPUs=$TOTAL_CPUS
        systemctl set-property --runtime -- init.scope AllowedCPUs=$TOTAL_CPUS

        for governor in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo $OFF_GOVERNOR > $governor;
        done
      fi

      if [ "$OPERATION" == "stopped" ] && [ "$SUB_OPERATION" == "end" ]; then
        killall looking-glass-client
      fi
    fi
  '';
in {
  systemd.services.libvirtd.serviceConfig.ExecStartPre = "+${libvirtdInit}";

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
