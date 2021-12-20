{ pkgs, ... }:

{
  services = {
    udev.packages = [ pkgs.dolphinEmuMaster ];

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

  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}
      GUEST_NAME="$1"
      OPERATION="$2"

      if [ "$GUEST_NAME" == "win11" ]; then
        if [ "$OPERATION" == "prepare" ]; then
          chown mado:kvm /dev/kvmfr0
          sync
          echo 3 > /proc/sys/vm/drop_caches
          sync
          echo 1 > /proc/sys/vm/compact_memory
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-7,16-23
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-7,16-23
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-7,16-23
        fi

        if [ "$OPERATION" == "release" ]; then
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-31
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-31
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-31
        fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';
}
