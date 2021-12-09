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
          };
        };

        pipewire-pulse = {
          "context.modules" = [
            {
              args = {
                "pulse.min.req" = "512/192000";
                "pulse.default.req" = "512/192000";
                "pulse.max.req" = "512/192000";
                "pulse.min.quantum" = "512/192000";
                "pulse.max.quantum" = "512/192000";
              };
            }
          ];

          "stream.properties" = {
            "node.latency" = "512/192000";
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

  systemd.services = {
    libvirtd.preStart = let
      qemuHook = unstable.writeScript "qemu-hook" ''
        #!${unstable.stdenv.shell}
        GUEST_NAME="$1"
        OPERATION="$2"

        if [ "$GUEST_NAME" == "win11" ]; then
          if [ "$OPERATION" == "start" ]; then
            sync
            echo 3 > /proc/sys/vm/drop_caches
            sync
            echo 1 > /proc/sys/vm/compact_memory
            systemctl set-property --runtime -- user.slice AllowedCPUs=0-7,16-23
            systemctl set-property --runtime -- system.slice AllowedCPUs=0-7,16-23
            systemctl set-property --runtime -- init.scope AllowedCPUs=0-7,16-23
          fi

          if [ "$OPERATION" == "stopped" ]; then
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

    prepare-ivshmem = {
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
  };
}
