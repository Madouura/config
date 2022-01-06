{ pkgs, ... }:

let
  qemuHook = pkgs.writeShellScript "qemu-hook.sh" ''
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"

    source "/var/lib/libvirt/hooks/vars.conf"

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
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  security.rtkit.enable = true;
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];
  systemd.tmpfiles.rules = [ "L+ /var/lib/libvirt/hooks/qemu - - - - ${qemuHook}" ];

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };

  virtualisation = {
    waydroid.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        swtpm.enable = true;

        verbatimConfig = ''
          namespaces = []

          cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom", "/dev/ptmx",
            "/dev/kvm", "/dev/rtc", "/dev/hpet", "/dev/kvmfr0"
          ]
        '';
      };
    };
  };
}
